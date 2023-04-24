import cv2
import torch
from PIL import Image
from yolov5 import YOLOv5
device = torch.device('cuda:0' if torch.cuda.is_available() else 'cpu')

"""
def detect_parking_violation(image_path, parking_zones, conf_thres=0.25, iou_thres=0.45):
    # Load YOLOv5 model
    model = YOLOv5("yolov5s.pt", device=device)

    # Load image
    img = Image.open(image_path).convert('RGB')

    # Run model
    results = model.predict(img, size=640)

    # Filter detections based on confidence threshold
    filtered_detections = results.xyxy[0][results.xyxy[0][:, 4] >= conf_thres]

    # Process detections
    violations = []
    for det in filtered_detections:
        x1, y1, x2, y2, conf, cls = det
        x1, y1, x2, y2 = int(x1), int(y1), int(x2), int(y2)
        if check_parking_violation_zones(x1, y1, x2, y2, parking_zones):
            violations.append((x1, y1, x2, y2))

    return violations


def draw_violations(image_path, violations):
    image = cv2.imread(image_path)
    for (x1, y1, x2, y2) in violations:
        cv2.rectangle(image, (x1, y1), (x2, y2), (0, 0, 255), 2)
        cv2.putText(image, "Violation", (x1, y1 - 5), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 255), 2)

    cv2.imshow("Parking Violations", image)
    cv2.waitKey(0)
    cv2.destroyAllWindows()
"""

def detect_parking_violation(image_path, parking_zones, conf_thres=0.25):
    # Load YOLOv5 model
    model = YOLOv5("yolov5s.pt", device=device)

    # Load image
    img = Image.open(image_path).convert('RGB')

    # Run model
    results = model.predict(img, size=640)

    # Filter detections based on confidence threshold
    filtered_detections = results.xyxy[0][results.xyxy[0][:, 4] >= conf_thres]

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

    return violations, non_violations
    
def check_parking_violation_zones(x1, y1, x2, y2, zones):
    for zone in zones:
        zone_x1, zone_y1, zone_x2, zone_y2 = zone
        if x1 >= zone_x1 and y1 >= zone_y1 and x2 <= zone_x2 and y2 <= zone_y2:
            return False
    return True


def draw_violations(image_path, violations, non_violations, parking_zones):
    image = cv2.imread(image_path)
    
    # Draw violations in red
    for (x1, y1, x2, y2) in violations:
        cv2.rectangle(image, (x1, y1), (x2, y2), (0, 0, 255), 2)
        cv2.putText(image, "Violation", (x1, y1 - 5), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 255), 2)


    # save the image 
    cv2.imwrite('output.jpg', image)

    # Draw parking zones in green
    for (x1, y1, x2, y2) in parking_zones:
        cv2.rectangle(image, (x1, y1), (x2, y2), (0, 255, 0), 2)

    # Draw non-violations in blue
    for (x1, y1, x2, y2) in non_violations:
        cv2.rectangle(image, (x1, y1), (x2, y2), (255, 0, 0), 2)

    # save the image 
    cv2.imwrite('debug_output.jpg', image)
    #cv2.imshow("Parking Violations", image)
    #cv2.waitKey(0)
    cv2.destroyAllWindows()


def main():
    image_path = 'input_image.jpg'

    # Define parking zones as a list of bounding boxes (x1, y1, x2, y2)
    parking_zones = [
        (40,25,20+94,200),
        (114,25,114+94,200),
        (198,25,194+94,200),
        (282,25,282+94,200),
        (366,25,366+94,200),
        (450,25,450+94,200),
        (534,25,534+94,200),
        (618,25,618+94,200),
        (702,25,702+94,200),
    ]

    # Detect parking violations
    violations, non_violations = detect_parking_violation(image_path, parking_zones, conf_thres=0.05)
    # Draw violations on the image and display it    
    draw_violations(image_path, violations, non_violations, parking_zones)


if __name__ == "__main__":
    main()