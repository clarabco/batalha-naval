// desenha os dois tabuleiros
for (var t = 0; t < 2; t++) {
    var gx = (t == 0) ? grid1_x : grid2_x;
    var gy = grid1_y;
    
    for (var col = 0; col < grid_cols; col++) {
        for (var row = 0; row < grid_rows; row++) {
            var cx = gx + col * cell_size;
            var cy = gy + row * cell_size;
            draw_set_alpha(0.2);
            draw_set_color(make_color_rgb(199, 39, 39));
            draw_rectangle(cx, cy, cx + cell_size, cy + cell_size, false);
            draw_set_alpha(1);
            draw_set_color(c_white);
            draw_rectangle(cx, cy, cx + cell_size, cy + cell_size, true);
        }
    }
}
draw_set_font(fnt_titulo);
draw_set_halign(fa_center);
draw_set_color(c_white);
draw_text(grid1_x + 250, grid1_y - 60, "JOGADOR");
draw_text(grid2_x + 250, grid2_y - 60, "OPONENTE");
draw_set_halign(fa_left);

// desenha as naves já posicionadas
for (var c = 0; c < grid_cols; c++) {
    for (var r = 0; r < grid_rows; r++) {
        var nave_id = grid_data[c, r];
        if (nave_id >= 0) {
            var eh_primeira_col = (c == 0 || grid_data[c-1, r] != nave_id);
            var eh_primeira_linha = (r == 0 || grid_data[c, r-1] != nave_id);
            if (eh_primeira_col && eh_primeira_linha) {
                var tamanho = naves[nave_id, 1];
                var largura = naves[nave_id, 2];
                draw_sprite_stretched(naves[nave_id, 0], 0,
                    grid1_x + c * cell_size,
                    grid1_y + r * cell_size,
                    cell_size * largura, cell_size * tamanho);
            }
        }
    }
}

// desenha os tiros no tabuleiro do oponente
for (var c = 0; c < grid_cols; c++) {
    for (var r = 0; r < grid_rows; r++) {
        var cx = grid2_x + c * cell_size + cell_size/2;
        var cy = grid1_y + r * cell_size + cell_size/2;
        var raio = cell_size/3;
        
        if (tiros[c, r] == 1) {
            // errou - X vermelho
            draw_set_color(make_color_rgb(199, 39, 39));
            draw_line_width(cx - raio, cy - raio, cx + raio, cy + raio, 3);
            draw_line_width(cx + raio, cy - raio, cx - raio, cy + raio, 3);
        } else if (tiros[c, r] == 2) {
            // acertou - círculo branco
            draw_set_color(c_white);
            draw_circle(cx, cy, raio, false);
        }
    }
}
draw_set_color(c_white);

// revela naves do oponente no game over
if (game_over) {
    for (var c = 0; c < grid_cols; c++) {
        for (var r = 0; r < grid_rows; r++) {
            var nave_id = grid_oponente[c, r];
            if (nave_id >= 0) {
                var eh_primeira_col = (c == 0 || grid_oponente[c-1, r] != nave_id);
                var eh_primeira_linha = (r == 0 || grid_oponente[c, r-1] != nave_id);
                if (eh_primeira_col && eh_primeira_linha) {
                    var tamanho = naves[nave_id, 1];
                    var largura = naves[nave_id, 2];
                    draw_sprite_stretched(naves[nave_id, 0], 0,
                        grid2_x + c * cell_size,
                        grid1_y + r * cell_size,
                        cell_size * largura, cell_size * tamanho);
                }
            }
        }
    }
}

// desenha os tiros do oponente no tabuleiro do jogador
for (var c = 0; c < grid_cols; c++) {
    for (var r = 0; r < grid_rows; r++) {
        var cx = grid1_x + c * cell_size + cell_size/2;
        var cy = grid1_y + r * cell_size + cell_size/2;
        var raio = cell_size/3;
        
        if (tiros_oponente[c, r] == 1) {
            draw_set_color(make_color_rgb(199, 39, 39));
            draw_line_width(cx - raio, cy - raio, cx + raio, cy + raio, 3);
            draw_line_width(cx + raio, cy - raio, cx - raio, cy + raio, 3);
        } else if (tiros_oponente[c, r] == 2) {
            draw_set_color(c_white);
            draw_circle(cx, cy, raio, false);
        }
    }
}
draw_set_color(c_white);

// mostra nave atual seguindo o mouse durante posicionamento
if (posicionando && nave_atual < 5) {
    var mx = mouse_x;
    var my = mouse_y;
    var col = floor((mx - grid1_x) / cell_size);
    var row = floor((my - grid1_y) / cell_size);
    
    if (col >= 0 && col < grid_cols && row >= 0 && row < grid_rows) {
        var tamanho = naves[nave_atual, 1];
        var largura = naves[nave_atual, 2];
        draw_sprite_stretched(naves[nave_atual, 0], 0, 
            grid1_x + col * cell_size, 
            grid1_y + row * cell_size, 
            cell_size * largura, cell_size * tamanho);
    }
    
    draw_set_halign(fa_center);
	draw_set_color(make_color_rgb(199, 39, 39))
	draw_text(room_width / 2, grid1_y - 125, "Posicionando nave " + string(nave_atual + 1) + " de 5");
	draw_set_color(c_white);
	draw_set_halign(fa_left);
}

if (game_over) {
    draw_set_halign(fa_center);
    draw_set_font(fnt_titulo);
    draw_set_color(c_yellow);
    draw_text(room_width / 2, 50, "GAME OVER - Clique para reiniciar");
    draw_set_halign(fa_left);
}

draw_set_alpha(1);