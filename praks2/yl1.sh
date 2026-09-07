#!/bin/bash
# kasutaja tunnused või mida iganes
echo -n "Tere, "

echo -n $(whoami | cut -c1 | tr [:lower:] [:upper:] )
echo -n $(whoami | cut -c2- )

echo "!"

