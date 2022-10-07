#!/bin/bash

echo "-- fixing line endings under resource folder"
sed -i -e 's/\r$//' resource/*
sed -i -e "s/\r//g" resource/*

echo "-- fixing line endings under config/current folder"
sed -i -e 's/\r$//' config/current/*
sed -i -e "s/\r//g" config/current/*

echo "-- fixing line endings under config/current folder"
sed -i -e 's/\r$//' config/original/*
sed -i -e "s/\r//g" config/original/*