import torch
import csv
import math


class ElementSet:
    def __init__(self, path):
        self.data = []
        with open(path, "r") as file:
            csv_reader = csv.reader(file)
            next(csv_reader)
            for row in csv_reader:
                self.data.append([
                    float(row[3]),  # atomic mass
                    float(row[4]),  # num neutrons
                    float(row[5]),  # num protons
                    float(row[7]),  # period
                    float(row[8]),  # group
                    *one_hot(["solid", "liq", "gas", "artificial"], row[9]),  # phase
                    float(row[10] == "yes"),  # radioactivity
                    float(row[11] == "yes"),  # natural
                    float(row[12] == "yes"),  # metal
                    float(row[13] == "yes"),  # nonmetal
                    float(row[14] == "yes"),  # metalloid
                    float(row[16]),  # atomic radius
                    float(row[18]),  # allen electronegativity
                    float(row[19]),  # first ionization energy
                    math.log(float(row[20])),  # density (natural log scale)
                    float(row[21]),  # melting point (kelvin)
                    float(row[22]),  # boiling point (kelvin)
                    float(row[23]),  # num isotopes
                    float(row[24]),  # specific heat
                    float(row[25]),  # num shells
                ])
        self.data = torch.tensor(self.data, dtype=torch.float32)
        min_vals = torch.min(self.data, dim=0)[0]
        max_vals = torch.max(self.data, dim=0)[0]
        self.data = (self.data - min_vals) / (max_vals - min_vals)


    def __len__(self):
        return self.data.size(0)

    def __getitem__(self, idx):
        return self.data[idx]

def one_hot(classes, class_to_encode):
    return [1 if i == class_to_encode else 0 for i in classes]
