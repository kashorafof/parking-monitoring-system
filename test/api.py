# app.py
from flask import Flask, request, jsonify, send_file
import base64
import io
from PIL import Image
import os

app = Flask(__name__)

# Import your functions from the provided script
from detect import detect_parking_violation, draw_violations

@app.route('/detect_parking_violations', methods=['POST'])
def detect_parking_violations():
    # Receive the image as a base64 encoded string
    image_data = request.form.get('image')
    if image_data is None:
        return jsonify({'error': 'No image data provided'}), 400

    # Define parking zones
    parking_zones = [
        (40, 25, 20 + 94, 200),
        (114, 25, 114 + 94, 200),
        (198, 25, 194 + 94, 200),
        (282, 25, 282 + 94, 200),
        (366, 25, 366 + 94, 200),
        (450, 25, 450 + 94, 200),
        (534, 25, 534 + 94, 200),
        (618, 25, 618 + 94, 200),
        (702, 25, 702 + 94, 200),
    ]

    # Convert the base64 encoded string to an image
    img_data = base64.b64decode(image_data)
    image = Image.open(io.BytesIO(img_data))
    image.save('input_image.jpg')

    # Detect parking violations
    violations, non_violations = detect_parking_violation('input_image.jpg', parking_zones, conf_thres=0.05)

    # Draw violations on the image
    draw_violations('input_image.jpg', violations, non_violations, parking_zones)

    # Read the output image and convert it to base64
    with open("output.jpg", "rb") as f:
        output_image_data = f.read()
    output_image_base64 = base64.b64encode(output_image_data).decode('utf-8')

    # Remove input and output images
    os.remove('input_image.jpg')
    os.remove('output.jpg')

    # Return the output image and the number of parking violations
    return jsonify({
        'output_image': output_image_base64,
        'violations_count': len(violations)
    })

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
