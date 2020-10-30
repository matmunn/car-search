"""
A command to search carsales.
"""

import json

import requests
from cfscrape import create_scraper

from bs4 import BeautifulSoup
from django.core.management.base import BaseCommand

from cars.models import Car


class Command(BaseCommand):
    """
    A command to search carsales.com.au
    """

    help = "A command to search for new cars for sale."

    def handle(self, *args, **options):
        scraper = create_scraper()
        response = scraper.get('https://www.carsales.com.au/cars/?q=(And.Price.range(..87000)._.Cylinders.8._.Drive.4x4._.(Or.BodyStyle.Cab+Chassis._.BodyStyle.Ute.)_.FuelType.Petrol+-+Unleaded+ULP._.Year.range(2014..).)&sort=~Price')
        soup = BeautifulSoup(response.content, 'html.parser')
        data = json.loads(soup.find(type='application/ld+json').string)
        try:
            cars = data["mainEntity"]["itemListElement"]
        except KeyError:
            return

        for car in cars:
            data = car["item"]
            try:
                car_km = int(data['mileageFromOdometer']['value'])
            except (KeyError, ValueError):
                car_km = 0

            try:
                car_price = int(data['offers']['price'])
            except (KeyError, ValueError):
                car_price = 0

            instance, created = Car.objects.get_or_create(
                url=data['url'],
                defaults={
                    'km': car_km,
                    'price': car_price,
                    'description': data['name']
                }
            )
            print(instance.__dict__)

