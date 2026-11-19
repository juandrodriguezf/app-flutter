class Resena {
  const Resena({
    required this.id,
    required this.componenteId,
    required this.nombreUsuario,
    required this.fecha,
    required this.calificacion,
    required this.fuente,
    required this.comentario,
    required this.esCompraVerificada,
    this.componenteNombre,
    this.authorId = '',
    this.imageUrl,
    this.likesCount = 0,
  });

  final String id;
  final String componenteId;
  final String nombreUsuario;
  final String fecha;
  final int calificacion;
  final String fuente;
  final String comentario;
  final bool esCompraVerificada;
  final String? componenteNombre;
  final String authorId;
  final String? imageUrl;
  final int likesCount;
}
