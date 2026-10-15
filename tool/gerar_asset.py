from PIL import Image, ImageDraw


WIDTH, HEIGHT = 1200, 600
image = Image.new("RGB", (WIDTH, HEIGHT), "#f0dfc7")
draw = ImageDraw.Draw(image)

# Parede e piso.
draw.rectangle((0, 0, WIDTH, 430), fill="#ead4b5")
draw.rectangle((0, 430, WIDTH, HEIGHT), fill="#68432e")

# Estantes laterais.
book_colors = ["#bd4e3b", "#d39b38", "#3f718c", "#65804c", "#873d55"]
for shelf_x in (55, 870):
    draw.rounded_rectangle((shelf_x, 65, shelf_x + 275, 450), radius=14, fill="#4b2e21")
    for row, shelf_y in enumerate((95, 200, 305)):
        draw.rectangle((shelf_x + 25, shelf_y, shelf_x + 250, shelf_y + 80), fill="#72503b")
        x = shelf_x + 37
        for index, width in enumerate((30, 34, 27, 39, 28)):
            height = 52 + ((index + row) * 7) % 24
            draw.rectangle(
                (x, shelf_y + 80 - height, x + width, shelf_y + 80),
                fill=book_colors[(index + row) % len(book_colors)],
            )
            x += width + 5

# Quadro e livro aberto.
draw.rounded_rectangle((430, 110, 770, 315), radius=14, fill="#fffaf2", outline="#8b6a50", width=9)
draw.polygon([(465, 165), (540, 148), (600, 170), (600, 275), (530, 258), (465, 270)], fill="#f2d8a9", outline="#6f4b35")
draw.polygon([(735, 165), (660, 148), (600, 170), (600, 275), (670, 258), (735, 270)], fill="#f2d8a9", outline="#6f4b35")
draw.line((600, 170, 600, 275), fill="#6f4b35", width=5)

# Mesa.
draw.ellipse((315, 448, 885, 532), fill="#4c3023")
draw.rounded_rectangle((425, 405, 775, 470), radius=18, fill="#76503a")
draw.rectangle((458, 462, 486, 567), fill="#4b2e21")
draw.rectangle((714, 462, 742, 567), fill="#4b2e21")

# Luminaria.
draw.ellipse((578, 34, 622, 78), fill="#ffd88a")
draw.line((600, 78, 600, 106), fill="#69482f", width=6)

image.save("assets/images/biblioteca.png", "PNG", optimize=True)
