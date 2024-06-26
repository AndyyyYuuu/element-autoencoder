import torch
import torch.nn as nn


class Autoencoder(nn.Module):

    def __init__(self, input_dim, encoding_dim):
        super(Autoencoder, self).__init__()

        self.encoder = nn.Sequential(
            nn.Linear(input_dim, 6),
            nn.ReLU(),
            nn.Linear(6, encoding_dim),
            #nn.ReLU(),
            #nn.Linear(5, encoding_dim),
        )
        self.decoder = nn.Sequential(
            #nn.Linear(encoding_dim, 5),
            #nn.ReLU(),
            nn.Linear(encoding_dim, 6),
            nn.ReLU(),
            nn.Linear(6, input_dim),
            nn.Sigmoid()
        )

    def forward(self, x):
        embedding = self.encoder(x)
        return self.decoder(embedding)