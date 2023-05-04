import requests
def detect_parking_violations(image_file):
    url = "http://localhost:5000/detect_violations"  # Replace with your API URL

    response = requests.post(url, files=image_file)

    if response.status_code == 200:
        try:
            result = response.json()
            output_image = result['output_image']
            num_violations = result['num_violations']
            print("Number of Violations:", num_violations)
            print("Output Image:", output_image)
        except ValueError:
            print("Error: Invalid JSON response")
    else:
        print("Error:", response.content)

def main():
    image_path = 'input_image.jpg'  # Replace with the path to your image

    with open(image_path, 'rb') as f:
        image_file = {'image': f}
        detect_parking_violations(image_file)

if __name__ == "__main__":
    main()
