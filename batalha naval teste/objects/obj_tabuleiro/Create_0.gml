//TABULEIRO

cell_size = 50;
grid_cols = 10;
grid_rows = 10;

// tabuleiro do jogador (esquerda)
grid1_x = 122;
grid1_y = 154;

// tabuleiro do inimigo (direita)
grid2_x = 744;
grid2_y = 154;

// array com as naves: [sprite, tamanho em células]
naves[0, 0] = spr_nave_pequena1;  naves[0, 1] = 2;  naves[0, 2] = 1;
naves[1, 0] = spr_nave_pequena2;  naves[1, 1] = 2;  naves[1, 2] = 1;
naves[2, 0] = spr_nave_media1;    naves[2, 1] = 3;  naves[2, 2] = 2;
naves[3, 0] = spr_nave_media2;    naves[3, 1] = 3;  naves[3, 2] = 2;
naves[4, 0] = spr_nave_grande;    naves[4, 1] = 5;  naves[4, 2] = 3;

nave_atual = 0;        // qual nave tá sendo posicionada agora
posicionando = true;   // true = fase de posicionamento

// grade pra guardar quais células têm naves
for (var c = 0; c < grid_cols; c++) {
    for (var r = 0; r < grid_rows; r++) {
        grid_data[c, r] = -1; // -1 = vazio
    }
}

//===========================================
//SISTEMA DO JOGO

// grade de tiros no tabuleiro do oponente
for (var c = 0; c < grid_cols; c++) {
    for (var r = 0; r < grid_rows; r++) {
        tiros[c, r] = 0; // 0 = não atirou, 1 = errou, 2 = acertou
    }
}

// naves do oponente (posicionadas aleatoriamente)
for (var c = 0; c < grid_cols; c++) {
    for (var r = 0; r < grid_rows; r++) {
        grid_oponente[c, r] = -1;
    }
}

// posiciona naves do oponente aleatoriamente
for (var n = 0; n < 5; n++) {
    var tamanho = naves[n, 1];
    var largura = naves[n, 2];
    var colocado = false;
    while (!colocado) {
        var rc = irandom(grid_cols - largura);
        var rr = irandom(grid_rows - tamanho);
        var livre = true;
        for (var i = 0; i < tamanho && livre; i++) {
            for (var j = 0; j < largura && livre; j++) {
                if (grid_oponente[rc + j, rr + i] != -1) {
                    livre = false;
                }
            }
        }
        if (livre) {
            for (var i = 0; i < tamanho; i++) {
                for (var j = 0; j < largura; j++) {
                    grid_oponente[rc + j, rr + i] = n;
                }
            }
            colocado = true;
        }
    }
}

// grade de tiros do oponente no tabuleiro do jogador
for (var c = 0; c < grid_cols; c++) {
    for (var r = 0; r < grid_rows; r++) {
        tiros_oponente[c, r] = 0;
    }
}