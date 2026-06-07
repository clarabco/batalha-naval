if (posicionando && nave_atual < 5) {
    var col = floor((mouse_x - grid1_x) / cell_size);
    var row = floor((mouse_y - grid1_y) / cell_size);
    var tamanho = naves[nave_atual, 1];
    
    // verifica se cabe na grade
    if (col >= 0 && col < grid_cols && row >= 0 && row + tamanho - 1 < grid_rows) {
        // verifica se as células estão livres
        var livre = true;
        for (var i = 0; i < tamanho; i++) {
            if (grid_data[col, row + i] != -1) {
                livre = false;
                break;
            }
        }
        
        if (livre) {
            // posiciona a nave
            for (var i = 0; i < tamanho; i++) {
                grid_data[col, row + i] = nave_atual;
            }
            nave_atual++;
            
            if (nave_atual >= 5) {
                posicionando = false;
                show_message("Todas as naves posicionadas! O jogo vai começar!");
            }
        }
    }
}