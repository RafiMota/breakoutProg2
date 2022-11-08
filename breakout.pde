int[] bloco = new int[20];

// Bola
int x = 250 + int(random(-50, 50)), y = 350;
int xVel = 3, yVel = -3;

// Jogador
int xJogador = 250, yJogador = 370;
int metadeJogador = 40;

int pontos = 0;

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
  boolean restamBlocos;
  restamBlocos = false;

  background(0);
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
  ellipse(x, y, 10, 10);

  // Jogador
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
      rect(xBarras + 40, yBarras + 10, 100, 20);
      restamBlocos = true;
    } else if (bloco[i] == 1) {
      fill(i * 10 % 360, 30, 70);
      rect(xBarras + 40, yBarras + 10, 100, 20);
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
      xJogador = xJogador + 8;
    } else if (keyCode == LEFT) {
      xJogador = xJogador - 8;
    }
  }
}

void keyPressed() {

  // Configuração do restart do jogo

  if (key == ' ') {
    // Restart
    x = 250 + int(random(-80, 80));
    y = 350;
    xVel = 3;
    yVel = -3;
    xJogador = 250;
    pontos = 0;

    for (int i = 0; i < 20; i++) {
      bloco[i] = 2;
    }
  }
}
