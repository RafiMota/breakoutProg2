int[] bloco = new int[20];

// Bola
int x = 250 + int(random(-50, 50)), y = 350;
int xVel = 3, yVel = -3;


// Jogador
int xJogador = 250, yJogador = 370;
int metadeJogador = 40;

int pontos = 0;
int seg;

void setup() {
  size(500, 400);
  noStroke();
  rectMode(CENTER);
  colorMode(HSB, 360, 100, 100);

  // Setando todos os blocos como existentes.
  for (int i = 0; i < 20; i++) {
    bloco[i] = 2;
  }
}

void draw() {
  int xBarras, yBarras;
  seg = frameCount / 60;
  boolean restamBlocos;
  restamBlocos = false;

  background(30);
  fill(255);

  // Movimentação da bola
  x = x + xVel;
  y = y + yVel;

  // Colisões da bolinha com as laterais e o topo da janela
  if (x > width || x < 0) {
    xVel = -xVel;
  }
  if (y < 0) {
    yVel = -yVel;
  }

  // Função de inputs do jogador
  jogador();

  // Mudança de direção da bola ao colidir com o jogador
  if ((xJogador - metadeJogador) < x && (xJogador + metadeJogador) > x &&
    (yJogador - 10) < y && (yJogador) > y) {
    yVel = -yVel;
  }

  textSize(16);
  textAlign(RIGHT);
  text("Pontos:", 80, 390);
  textAlign(LEFT);
  text(pontos, 90, 390);

  // Bola
  fill(200, corBolinha, 100);
  ellipse(x, y, 10, 10);

  // Jogador
  fill(0, corJogador, 100);
  rect(xJogador, yJogador, metadeJogador * 2, 11);

  if (y > height) {
    textSize(40);
    textAlign(CENTER);
    text("Fim de Jogo", 250, 250);
  }

  // Loop em todos os blocos
  for (int i = 0; i < 20; i++) {

    // Cálculo da posição x e y do canto superior direito
    xBarras = i % 5 * 100 + 10;
    yBarras = 40 * (i / 5) + 10;

    // Criação / verificação de existência de blocos restantes

    if (bloco[i] == 2) {
      fill(i * 10 % 360, 50, 100);
      rect(xBarras + 40, yBarras + 10, 80, 20);
      restamBlocos = true;
    } else if (bloco[i] == 1) {
      fill(i * 10 % 360, 30, 70);
      rect(xBarras + 40, yBarras + 10, 80, 20);
      restamBlocos = true;
    }

    // Verifica colisão superior e inferior. Se positivo, seta o bloco como 0 (inexistente)

    if (x > (xBarras + 4) && x < (xBarras + 76) &&
      y > yBarras && y < (yBarras + 20) && bloco[i] == 2) {
      bloco[i] = bloco[1] - 1;
      yVel = -yVel;
      pontos = pontos + 5;
    } else if (x > (xBarras + 4) && x < (xBarras + 76) &&
      y > yBarras && y < (yBarras + 20) && bloco[i] == 1) {
      bloco[i] = bloco[i] - 1;
      yVel = -yVel;
      pontos = pontos + 5;
    }

    // Colisão lateral
    if (((x > (xBarras - 5) && x < xBarras) || (x > (xBarras + 80) && x < (xBarras + 85))) &&
      y > yBarras && y < (yBarras + 20) && bloco[i] == 2) {
      bloco[i] = bloco[i] - 1;
      xVel = -xVel;
      yVel = -yVel;
      pontos = pontos + 5;
    } else if (((x > (xBarras - 5) && x < xBarras) || (x > (xBarras + 80) && x < (xBarras + 85))) &&
      y > yBarras && y < (yBarras + 20) && bloco[i] == 1) {
      bloco[i] = bloco[i] - 1;
      xVel = -xVel;
      yVel = -yVel;
      pontos = pontos + 5;
    }

    if (((x > (xBarras - 1) && x < (xBarras + 5)) || (x > (xBarras + 75) && x < (xBarras + 81))) &&
      y > yBarras && y < (yBarras + 20) && bloco[i] == 2) {

      bloco[i] = bloco[i] - 1;
      xVel = -xVel;
      yVel = -yVel;
      pontos = pontos + 5;
    } else if (((x > (xBarras - 1) && x < (xBarras + 5)) || (x > (xBarras + 75) && x < (xBarras + 81))) &&
      y > yBarras && y < (yBarras + 20) && bloco[i] == 2) {
      bloco[i] = bloco[i] - 1;
      xVel = -xVel;
      yVel = -yVel;
      pontos = pontos + 5;
    }
  }

  if (restamBlocos == false) {
    textSize(40);
    textAlign(CENTER);
    text("Você venceu!", 250, 210);
  }

  if (xP < 0 || xP > width) {
    xPvel = -xPvel;
  }
  if (xP2 < 0 || xP2 > width) {
    xPvel2 = -xPvel2;
  }
  if (xP3 < 0 || xP3 > width) {
    xPvel3 = -xPvel3;
  }
  if (xP4 < 0 || xP4 > width) {
    xPvel4 = -xPvel4;
  }

  println(frameCount);
  if (seg > 2) {
    powerUpVelJogador();
  }
  if (seg > 6) {
    powerUpCorBolinha();
  }
  if (seg > 10) {
    powerUpCorPersonagem();
  }
  if (seg > 15) {
    powerUpQuebraBloco();
  }
}

// Coordenadas dos power-ups
int xP = 250 + int(random(-100, 50)), yP = 180 + int(random(20, 50));
int xP2 = 250 + int(random(-100, 50)), yP2 = 200 + int(random(20, 50));
int xP3 = 250 + int(random(-100, 50)), yP3 = 220 + int(random(20, 50));
int xP4 = 250 + int(random(-100, 50)), yP4 = 240 + int(random(20, 50));
int xPvel = 5, xPvel2 = 5, xPvel3 = 5, xPvel4 = 5;

int blocoAleat = int(random(20));
int velJogador = 8;
int corJogador = 0;
int corBolinha = 0;

boolean estadoPU = true;
boolean estadoPU2 = true;
boolean estadoPU3 = true;
boolean estadoPU4 = true;

// --- Sessão de funções dos power-ups ---

// PowerUp que muda a cor do personagem
void powerUpCorPersonagem() {
  if (estadoPU == true) {
    fill(0, 80, 100);
    rect(xP + 10, yP, 20, 20);
    corJogador = 0;
  } else {
    corJogador = 60;
  }
  xP = xP + xPvel;
  if (yJogador <= yP + 10 && yJogador >= yP - 10 && xJogador <= xP + 40 && xJogador >= xP - 40) {
    estadoPU = false;
  }
}

void powerUpCorBolinha() {
  if (estadoPU2 == true) {
    fill(200, 80, 100);
    rect(xP2 + 10, yP2, 20, 20);
    corBolinha = 0;
  } else {
    corBolinha = 60;
  }
  xP2 = xP2 + xPvel2;
  if (yJogador <= yP2 + 10 && yJogador >= yP2 - 10 && xJogador <= xP2 + 40 && xJogador >= xP2 - 40) {
    estadoPU2 = false;
  }
}

void powerUpVelJogador() {
  if (estadoPU3 == true) {
    fill(100, 80, 100);
    rect(xP3 + 10, yP3, 20, 20);
    velJogador = 8;
  } else {
    velJogador = 5;
  }
  xP3 = xP3 + xPvel3;
  if (yJogador <= yP3 + 10 && yJogador >= yP3 - 10 && xJogador <= xP3 + 40 && xJogador >= xP3 - 40) {
    estadoPU3 = false;
  }
}

void powerUpQuebraBloco() {
  if (estadoPU4 == true) {
    fill(50, 80, 100);
    rect(xP4 + 10, yP4, 20, 20);
  } else {
    bloco[blocoAleat] = bloco[blocoAleat] - 1;
  }
  xP4 = xP4 + xPvel4;
  if (yJogador <= yP4 + 10 && yJogador >= yP4 - 10 && xJogador <= xP4 + 40 && xJogador >= xP4 - 40) {
    estadoPU4 = false;
  }
}

void jogador() {

  // Limitação de movimento pelas bordas
  if (xJogador < metadeJogador) {
    xJogador = metadeJogador;
  } else if (xJogador > width - metadeJogador) {
    xJogador = width - metadeJogador;
  }

  // Movimentação do personagem
  if (keyPressed) {
    if (keyCode == RIGHT) {
      xJogador = xJogador + velJogador;
    } else if (keyCode == LEFT) {
      xJogador = xJogador - velJogador;
    }
    if (keyCode == UP) {
      yJogador = yJogador - velJogador;
    } else if (keyCode == DOWN) {
      yJogador = yJogador + velJogador;
    }
  }
}

// --- Fim da sessão dos power-ups ---
void keyPressed() {

  // Configuração do restart do jogo

  if (key == ' ') {
    // Restart
    x = 250 + int(random(-80, 80));
    y = 350;
    xVel = 3;
    yVel = -3;
    xJogador = 250;
    yJogador = 370;
    pontos = 0;
    estadoPU = true;
    estadoPU2 = true;
    estadoPU3 = true;
    estadoPU4 = true;

    for (int i = 0; i < 20; i++) {
      bloco[i] = 2;
    }
  }
}
