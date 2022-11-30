# check if pin 18 is not exported export it
if [[ $(ls /sys/class/gpio | grep gpio18) = 'gpio18' ]]
then
    echo 'pin 18 already is open!'
else 
    echo 'openning prot 18'
    echo 18 >/sys/class/gpio/export
    echo 'prot 18 is opened'
fi
# set pin 18 mode to output
echo out >/sys/class/gpio/gpio18/direction

echo 'to exit press q '

while : ; do
    # turn on the LED
    echo 1 >/sys/class/gpio/gpio18/value
    sleep 1
    # terminates loop if user press q 
    read -t 1 -n 1 key
    if [[ $key = 'q' ]] 
    then 
        echo
        # turn off LED then release pin 18
        echo 0 >/sys/class/gpio/gpio18/value
        echo 18 >/sys/class/gpio/unexport
        break
    fi
    # turn off the LED for a secound
    echo 0 >/sys/class/gpio/gpio18/value
    sleep 1
done
