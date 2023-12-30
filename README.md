# DevOps RoboShop Project

```
https://gitlab.com/giridharvedula/devopsroboshop.git
```

# Project details:
## <a> Project is having the following components as microservices and each component as an individual server (instance) to host the data.</a>

    1. Frontend - Nginx web server instance 
    2. MongoDB - Database server instance
    3. Catalogue - Catalogue instance 
    4. Redis - Cache server instance 
    5. User - User database instance 
    6. Cart - Cart instance to hold added items 
    7. MySQl - Product database instance 
    8. Shipping - Details database instance
    9. RabbitMQ - Message handler instance 
    10. Payment - Payment processing instance 
    11. Dispatch - Delivery report instance

> ## <a> _shell-auto-config directory files_ </a> 
>> 1. `frontend.sh --> roboshop.conf`
>> 2. `mongodb.sh --> mongodb.repo`
>> 3. `catalogue.sh --> catalogue.service`
>> 4. `redis.sh`
>> 5. `user.sh --> user.service`
>> 6. `car.sh --> car.service`
>> 7. `mysql.sh --> mysql.repo` 
>> 8. `shipping.sh --> shipping.service`
>> 9. `rabbitmq.sh` 
>> 10. `payment.sh --> payment.service`
>> 11. `dispatch.sh`
>> 12. `common.sh`
