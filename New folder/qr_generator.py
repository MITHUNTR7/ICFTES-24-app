import qrcode
from PIL import Image, ImageDraw, ImageFont
import os

# Generate IDs from ICLST_0001 to ICLST_0250
ids = [f"ICFTES_{i:04d}" for i in range(1, 351)]

# Path to save the QR codes
output_folder = "qr_codes/"

# Create the directory if it doesn't exist
if not os.path.exists(output_folder):
    os.makedirs(output_folder)

# Function to generate QR code
def generate_qr_code(data, filename):
    qr = qrcode.QRCode(
        version=1,
        error_correction=qrcode.constants.ERROR_CORRECT_L,
        box_size=10,
        border=4,
    )
    qr.add_data(data)
    qr.make(fit=True)

    img = qr.make_image(fill_color="black", back_color="white").convert('RGB')
    
    # Add ID text below the QR code
    draw = ImageDraw.Draw(img)
    font = ImageFont.truetype("arial.ttf", 16)
    text_bbox = draw.textbbox((0, 0), data, font=font)
    text_width = text_bbox[2] - text_bbox[0]
    text_height = text_bbox[3] - text_bbox[1]
    # draw.text(((img.size[0] - text_width) / 2, img.size[1] - text_height - 10), data, fill="black", font=font)

    # Resize canvas to fit the text below the QR code
    new_img = Image.new('RGB', (img.size[0], img.size[1] + text_height + 10), 'white')
    new_img.paste(img, (0, 0))
    draw = ImageDraw.Draw(new_img)
    draw.text(((new_img.size[0] - text_width) / 2, img.size[1] + 5), data, fill="black", font=font)

    new_img.save(output_folder + filename)

# Generate QR codes for each ID
for id in ids:
    generate_qr_code(id, id + ".png")

print("QR codes generated successfully!")
