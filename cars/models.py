from django.db import models

# Create your models here.

class Car(models.Model):
    """
    A car.
    """
    km = models.PositiveIntegerField()
    price = models.PositiveIntegerField()
    url = models.URLField()
    description = models.TextField()

    def __str__(self):
        return f"{self.description} (${self.price})"
