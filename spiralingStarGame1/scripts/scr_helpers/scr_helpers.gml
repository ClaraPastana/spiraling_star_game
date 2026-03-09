/// @description Funções auxiliares do 9 Dots Problem
 
// ─── Distância de Ponto a Segmento de Reta ───────────────────────────
// Retorna a menor distância entre o ponto (px,py) e o segmento (x1,y1)-(x2,y2)
function point_to_segment_distance(px, py, x1, y1, x2, y2) {
    var dx = x2 - x1;
    var dy = y2 - y1;
    var len_sq = dx * dx + dy * dy;
 
    // Segmento degenerado (comprimento zero): retorna distância ao ponto
    if (len_sq == 0) return point_distance(px, py, x1, y1);
 
    // Parâmetro t: projeção do ponto sobre a reta, clampado a [0,1]
    var t = clamp(((px - x1) * dx + (py - y1) * dy) / len_sq, 0, 1);
 
    // Ponto mais próximo na reta
    var closest_x = x1 + t * dx;
    var closest_y = y1 + t * dy;
 
    return point_distance(px, py, closest_x, closest_y);
}
 
// ─── Recalcula quais pontos foram tocados ────────────────────────────
function recalculate_hits() {
    // Reset todos os pontos
    for (var i = 0; i < obj_controller.dot_count; i++) {
        obj_controller.dot_hit[i] = false;
    }
 
    // Para cada linha registrada, verifica todos os pontos
    for (var li = 0; li < obj_controller.line_count; li++) {
        var lx1 = obj_controller.line_x1[li];
        var ly1 = obj_controller.line_y1[li];
        var lx2 = obj_controller.line_x2[li];
        var ly2 = obj_controller.line_y2[li];
 
        for (var di = 0; di < obj_controller.dot_count; di++) {
            var dist = point_to_segment_distance(
                obj_controller.dot_x[di],
                obj_controller.dot_y[di],
                lx1, ly1, lx2, ly2
            );
            if (dist <= obj_controller.hit_radius) {
                obj_controller.dot_hit[di] = true;
            }
        }
    }
}
 
// ─── Verifica se todos os pontos foram tocados ───────────────────────
function all_dots_hit() {
    for (var i = 0; i < obj_controller.dot_count; i++) {
        if (!obj_controller.dot_hit[i]) return false;
    }
    return true;
}
 
// ─── Reinicia o Jogo ─────────────────────────────────────────────────
function reset_game() {
    with (obj_controller) {
        line_count  = 0;
        is_drawing  = false;
        game_won    = false;
        show_hint   = true;
        for (var i = 0; i < dot_count; i++) {
            dot_hit[i] = false;
        }
    }
}
