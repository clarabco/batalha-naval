if (game_over) {
    game_restart();
    exit;
}

if (posicionando && nave_atual < 5) {
    var col = floor((mouse_x - grid1_x) / cell_size);
    var row = floor((mouse_y - grid1_y) / cell_size);
    var tamanho = naves[nave_atual, 1];
    
    if (col >= 0 && col < grid_cols && row >= 0 && row + tamanho - 1 < grid_rows) {
        var livre = true;
        for (var i = 0; i < tamanho; i++) {
            if (grid_data[col, row + i] != -1) {
                livre = false;
                break;
            }
        }
        if (livre) {
            var largura = naves[nave_atual, 2];
            for (var i = 0; i < tamanho; i++) {
                for (var j = 0; j < largura; j++) {
                    if (col + j < grid_cols) {
                        grid_data[col + j, row + i] = nave_atual;
                    }
                }
            }
            nave_atual++;
            if (nave_atual >= 5) {
                posicionando = false;
                show_message("Todas as naves posicionadas! O jogo vai começar!");
            }
        }
    }
}

// lógica de tiro
if (!posicionando) {
    var col = floor((mouse_x - grid2_x) / cell_size);
    var row = floor((mouse_y - grid1_y) / cell_size);
    
    if (col >= 0 && col < grid_cols && row >= 0 && row < grid_rows) {
        if (tiros[col, row] == 0) {
            if (grid_oponente[col, row] != -1) {
                tiros[col, row] = 2;
            } else {
                tiros[col, row] = 1;
            }
        }
    }
}

// oponente atira
if (!posicionando) {
    var atirou = false;
    var tentativas = 0;
    while (!atirou && tentativas < 200) {
        var ac = irandom(grid_cols - 1);
        var ar = irandom(grid_rows - 1);
        if (tiros_oponente[ac, ar] == 0) {
            if (grid_data[ac, ar] != -1) {
                tiros_oponente[ac, ar] = 2;
            } else {
                tiros_oponente[ac, ar] = 1;
            }
            atirou = true;
        }
        tentativas++;
    }
}

// verifica vitória
var total_celulas_op = 0;
var acertadas_op = 0;
for (var c = 0; c < grid_cols; c++) {
    for (var r = 0; r < grid_rows; r++) {
        if (grid_oponente[c, r] != -1) {
            total_celulas_op++;
            if (tiros[c, r] == 2) acertadas_op++;
        }
    }
}
if (total_celulas_op == acertadas_op && acertadas_op > 0) {
    game_over = true;
	show_message("VOCÊ VENCEU! Todas as naves inimigas foram destruídas!");
}

// verifica derrota
var total_celulas_jog = 0;
var acertadas_jog = 0;
for (var c = 0; c < grid_cols; c++) {
    for (var r = 0; r < grid_rows; r++) {
        if (grid_data[c, r] != -1) {
            total_celulas_jog++;
            if (tiros_oponente[c, r] == 2) acertadas_jog++;
        }
    }
}
if (total_celulas_jog == acertadas_jog && acertadas_jog > 0) {
    game_over = true;
	show_message("VOCÊ PERDEU! Suas naves foram todas destruídas!");
}