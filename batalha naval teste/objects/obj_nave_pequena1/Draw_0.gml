var tab = obj_tabuleiro;
var px = tab.grid1_x + grid_x * tab.cell_size;
var py = tab.grid1_y + grid_y * tab.cell_size;
draw_sprite_stretched(sprite_index, 0, px, py, tab.cell_size, tab.cell_size * tamanho);