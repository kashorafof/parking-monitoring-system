from flask import Flask, request, jsonify
from werkzeug.utils import secure_filename
import os
import cv2
import torch
from PIL import Image
from yolov5 import YOLOv5
device = torch.device('cuda:0' if torch.cuda.is_available() else 'cpu')
app = Flask(__name__)
UPLOAD_FOLDER = 'uploads'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
app.config['ALLOWED_EXTENSIONS'] = {'png', 'jpg', 'jpeg'}

# Load YOLOv5 model
model = YOLOv5("yolov5s.pt", device=device)

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in app.config['ALLOWED_EXTENSIONS']

@app.route('/detect_violations', methods=['POST'])
def detect_violations():
    # Check if a file was uploaded
    if 'image' not in request.files:
        return jsonify({'error': 'No image uploaded'}), 400
    
    image_file = request.files['image']

    # Validate file extension
    if not allowed_file(image_file.filename):
        return jsonify({'error': 'Invalid file type. Only PNG, JPG, and JPEG are allowed.'}), 400

    # Save the uploaded file
    filename = secure_filename(image_file.filename)
    image_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
    image_file.save(image_path)

    # Load image
    img = Image.open(image_path).convert('RGB')

    # Run model
    results = model.predict(img, size=640)

    # Filter detections based on confidence threshold
    filtered_detections = results.xyxy[0][results.xyxy[0][:, 4] >= 0.25]

    # Process detections
    violations = []
    non_violations = []
    for det in filtered_detections:
        x1, y1, x2, y2, conf, cls = det
        x1, y1, x2, y2 = int(x1), int(y1), int(x2), int(y2)
        if check_parking_violation_zones(x1, y1, x2, y2, parking_zones):
            violations.append((x1, y1, x2, y2))
        else:
            non_violations.append((x1, y1, x2, y2))

    # Draw violations on the image
    draw_violations(image_path, violations, non_violations, parking_zones)

    # Count the number of violations
    num_violations = len(violations)

    # Create a response with the output image and number of violations
    response = {
        'output_image': 'output.jpg',
        'num_violations': num_violations
    }

    return jsonify(response)

if __name__ == "__main__":
    app.run()

