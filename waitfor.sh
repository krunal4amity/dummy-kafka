while [ "$(nc -zv kafka 9092 | echo $?)" -eq 1 ]
do
    sleep 10
    echo "sleeping for 10 secs..."
done
sleep 10
npm start