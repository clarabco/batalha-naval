// desenha os dois tabuleiros
for (var t = 0; t < 2; t++) {
    var gx = (t == 0) ? grid1_x : grid2_x;
    var gy = grid1_y;
    
    for (var col = 0; col < grid_cols; col++) {
        for (var row = 0; row < grid_rows; row++) {
            var cx = gx + col * cell_size;
            var cy = gy + row * cell_size;
            draw_set_alpha(0.3);
            draw_set_color(c_navy);
            draw_rectangle(cx, cy, cx + cell_size, cy + cell_size, false);
            draw_set_alpha(1);
            draw_set_color(c_white);
            draw_rectangle(cx, cy, cx + cell_size, cy + cell_size, true);
        }
    }
}

draw_set_font(-1);
draw_set_halign(fa_center);
draw_set_color(c_white);
draw_set_font(fnt_titulo);
draw_text(grid1_x + 250, grid1_y - 60, "JOGADOR");
draw_text(grid2_x + 250, grid2_y - 60, "OPONENTE");
draw_set_halign(fa_left);

draw_set_alpha(1);