import base64
import requests
from PIL import Image

# Load the image and convert it to a base64 encoded string
with open("test_image.jpg", "rb") as f:
    img_data = f.read()
image_base64 = base64.b64encode(img_data).decode("utf-8")

# Send the image to the API
url = "http://localhost:5000/detect_parking_violations"

data = {"image": image_base64}
response = requests.post(url, data=data)

# Check if the request was successful
if response.status_code == 200:
    json_data = response.json()

    # Save the output image
    output_image_base64 = json_data["output_image"]
    output_image_data = base64.b64decode(output_image_base64)
    with open("output_image.jpg", "wb") as f:
        f.write(output_image_data)

    # Print the number of violations
    violations_count = json_data["violations_count"]
    print(f"Number of parking violations: {violations_count}")
else:
    print(f"Error: {response.status_code} - {response.text}")
