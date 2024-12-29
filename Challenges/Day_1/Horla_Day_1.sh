#!/bin/bash


#Bash Script is an automation tool which is used for writing script to make your automate your work faster and better.

echo "Welcome to my Bash Script! This is my First Task Assessment"

echo "What is your name?"

read name

echo "Welcome $name!, I hope you will enjoy this task."

echo "Let's do simple calculation"

echo "Enter the first number:"
read num1

echo "Enter the second number:"
read num2

num3=$((num1 + num2))

echo "Your result is: $num3"

 ls *.txt #*.txt is a wildcard that matches any string ending with .txt