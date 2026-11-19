class Componente {
  const Componente({
    required this.id,
    required this.nombre,
    required this.imageAsset,
    required this.costo,
    required this.consumoEnergetico,
    required this.fechaLanzamiento,
    required this.subCategoria,
    required this.marca,
    this.promedioCalificacion = 0,
    this.totalResenas = 0,
    this.socket,
    this.tipoRam,
    this.vatios,
    this.largoMm,
    this.largoMaxGpuMm,
    this.socketsSoportados = const <String>[],
  });

  final String id;
  final String nombre;
  final String imageAsset;
  final double costo;
  final double consumoEnergetico;
  final String fechaLanzamiento;
  final String subCategoria;
  final String marca;
  final double promedioCalificacion;
  final int totalResenas;
  final String? socket;
  final String? tipoRam;
  final int? vatios;
  final int? largoMm;
  final int? largoMaxGpuMm;
  final List<String> socketsSoportados;
}
