import torch
import torch.nn as nn
import csv
from model import Autoencoder
from dataset import ElementSet

NUM_EPOCHS = 10000
DATA_PATH = "data/Periodic Table of Elements.csv"
OUTPUT_PATH = "display_elements/data/elements-2.csv"

loss_function = nn.MSELoss()

dataset = ElementSet(DATA_PATH)

data_loader = torch.utils.data.DataLoader(dataset, batch_size=5)

model = Autoencoder(21, 2)
optimizer = torch.optim.Adam(model.parameters(), lr=0.003)

for epoch in range(NUM_EPOCHS):
    model.train()
    losses = []
    for batch_idx, inputs in enumerate(data_loader):
        optimizer.zero_grad()
        outputs = model(inputs)
        loss = loss_function(outputs, inputs)
        loss.backward()
        optimizer.step()

        losses.append(loss)
    print(f"Epoch {epoch} Avg. Train Loss: {sum(losses)/len(losses)}")

# Format and output results in csv
results = []
with open(DATA_PATH, "r") as file:
    csv_reader = csv.reader(file)
    next(csv_reader)
    for row in csv_reader:
        results.append(row[1:3])  # row 1, 2 are element name and symbol respectively

for i in range(len(dataset)):
    results[i] += model.encoder(dataset.data[i]).tolist()

with open(OUTPUT_PATH, 'w', newline='') as csvfile:
    csv_writer = csv.writer(csvfile)
    for row in results:
        csv_writer.writerow(row)