FROM node:8.10.0

WORKDIR /var/www

COPY package*.json /var/www

RUN npm install --only=production

COPY . /var/www

EXPOSE 8000

CMD ["npm", "run", "build"]






