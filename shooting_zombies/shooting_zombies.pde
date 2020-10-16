Shooter shooter ;
Zombie[] zombies ;
Bullet[] bullets;
int killed = 0 ;

void setup() {
  background(255);
  size(1200, 600);
  shooter = new Shooter(width/2, height/2);
  zombies = new Zombie[10];
  bullets = new Bullet[1000];
  for (int i = 0; i < zombies.length; i++) {
    zombies[i] = new Zombie();
  }
  textMode(CENTER);
  textSize(50);
  text(killed, 600, 50);
}

void draw() {
  background(255);
  text(killed, 600, 50);
  if (keyPressed == true) {
    if (key == CODED) {
      shooter.move(keyCode);
    }
  }
  fill(255);
  rect(shooter.positionX, shooter.positionY - shooter.size/2, 10, 25);
  circle(shooter.positionX, shooter.positionY, shooter.size);
  fill(0);
  for (int i = 0; i < zombies.length; i++) {
    zombies[i].move(shooter.positionX, shooter.positionY);
    zombies[i].kill(shooter.positionX, shooter.positionY);
    for (int j = i+1; j < zombies.length; j++){
      if (dist(zombies[i].positionX, zombies[i].positionY, zombies[j].positionX, zombies[j].positionY) < zombies[i].size){
        zombies[j].move(shooter.positionX, shooter.positionY);
      }
    }
  }
  shooter.shoot();   
  for (int i = 0; i < bullets.length; i++) {
    if (bullets[i] != null) {
      bullets[i].move();
    }
  }

  for (int j = 0; j < bullets.length; j ++) {

    for (int i = 0; i < zombies.length; i ++) {
      if (bullets[j] != null) {
        
        if (dist(zombies[i].positionX, zombies[i].positionY, bullets[j].positionX, bullets[j].positionY) < 30) {
          bullets[j] = null;
          zombies[i].size = zombies[i].size * zombies[i].resize;
          zombies[i].livecount += 1;
          
        }
        
        if(zombies[i].livecount == 3){
          zombies[i] = new Zombie();
          bullets[j] = null;
          killed += 1 ;
        }
        }
      }
    }
  }


class Shooter {
  float positionX, positionY, size, speed;

  Shooter(float positionX, float positionY) {
    this.positionX = positionX ;
    this.positionY = positionY ;
    this.size = 50 ;
    this.speed = 2 ;
    rectMode(CENTER);
    rect(this.positionX, this.positionY - this.size, 10, 20);
    circle(this.positionX, this.positionY, 50);
  }

  void move(float direction) {
    if (direction == UP) {
      this.positionY -= this.speed;
    }
    if (direction == DOWN) {
      this.positionY += this.speed;
    }
    if (direction == LEFT) {
      this.positionX -= this.speed;
    }
    if (direction == RIGHT) {
      this.positionX += this.speed;
    }
    if (this.positionX > width) this.positionX = width;
    if (this.positionX < 0) this.positionX = 0 ;
    if (this.positionY > height) this.positionY = height;
    if (this.positionY < 0) this.positionY = 0 ;
    rect(this.positionX, this.positionY - this.size/2, 10, 25);
    circle(this.positionX, this.positionY, this.size);
  }

  void shoot() {
    if (keyPressed && key == ' ') {
      if (frameCount % 10 == 0){
        bullets = (Bullet[])append(bullets, new Bullet(this.positionX, this.positionY));
        println(frameCount);
      }
       println(frameCount);
    }
  }
} 

class Bullet {
  float positionX, positionY, speed, size ;

  Bullet(float positionX, float positionY) {
    this.positionX = positionX ;
    this.positionY = positionY ;
    this.speed = 4 ;
    this.size = 10 ;
    circle(this.positionX, this.positionY - 25, this.size);
  }

  void move() {
    if (this.positionY >= 0 ) {
      this.positionY -= this.speed ;
      circle(this.positionX, this.positionY, this.size);
    }
  }
}



class Zombie {
  float targetX, targetY, speed, positionX, positionY, size , resize,livecount;
  Zombie() {
    this.targetX = positionX ;
    this.targetY = positionY ;
    this.positionX = random(0, 1200) ;
    this.positionY = 0 ;
    this.speed = 0.5 ;
    this.size = 60 ;
    this.resize = 1.2;
    this.livecount = 0;
    circle(this.positionX, this.positionY, this.size);
  }

  void move(float targetX, float targetY) {
    fill(0);
    if (this.positionX > targetX) {
      this.positionX -= this.speed ;
    }
    if (this.positionX < targetX) {
      this.positionX += this.speed ;
    }
    if (this.positionY < targetY) {
      this.positionY += this.speed ;
    }
    if (this.positionY > targetY) {
      this.positionY -= this.speed ;
    }
    rect(this.positionX - this.size/2, this.positionY + this.size/2, 10, this.size/2 );
    rect(this.positionX + this.size/2, this.positionY + this.size/2, 10, this.size/2 );
    circle(this.positionX, this.positionY, this.size);
  }

  void kill(float positionX, float positionY) {
    if (dist(this.positionX, this.positionY, positionX, positionY) < 50 ) {
      println("YOU ARE LOSE!!");
      delay(4000);
      exit();
    }
    else if (killed == 10){
      println("YOU ARE WIN!!!");
      delay(4000);
      exit();
    }
  }
}
