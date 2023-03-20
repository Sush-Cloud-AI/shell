#!/bin/bash
echo "Hello"

## Printing mutliple line 

echo "Hello"
echo "HI"

## \n : New line  : \t : Tab

echo -e "Hello\n\tmonkey"

#colour fore ground

echo -e "\e[31mI am Red\e[0m"
echo -e "\e[32mI am Green\e[0m"
echo -e "\e[33mI am yellow\e[0m"
echo -e "\e[34mI am Blue\e[0m"
echo -e "\e[35mI am Maganta\e[0m"

# forefround clour
echo -e "\e[45;33mI am yellow\e[0m"

#echo -e "\n"

echo -e "\e[46;31mI am Red\e[0m"