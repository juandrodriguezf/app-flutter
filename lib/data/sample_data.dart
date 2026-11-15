import '../models/componente.dart';
import '../models/resena.dart';

const demoUserId = 'demo-user';

const sampleComponentes = <Componente>[
  Componente(
    id: 'comp-1',
    nombre: 'Tarjeta gráfica GeForce RTX 5060',
    imageAsset: 'assets/images/components/gpu_rtx5060.jpg',
    costo: 1000.0,
    consumoEnergetico: 450.0,
    fechaLanzamiento: '2025/05/18',
    subCategoria: 'GPU',
    marca: 'GYGABITE',
    promedioCalificacion: 4.0,
    totalResenas: 4,
  ),
  Componente(
    id: 'comp-2',
    nombre: 'Procesador de escritorio Core™ i7-12700KF',
    imageAsset: 'assets/images/components/cpu_i7_12700kf.jpg',
    costo: 250.9,
    consumoEnergetico: 120.0,
    fechaLanzamiento: '2025/07/2',
    subCategoria: 'CPU',
    marca: 'INTEL',
    promedioCalificacion: 4.8,
    totalResenas: 5,
  ),
  Componente(
    id: 'comp-3',
    nombre: 'GeForce RTX 4080 Super',
    imageAsset: 'assets/images/components/gpu_rtx4080_super.jpg',
    costo: 999.99,
    consumoEnergetico: 320.0,
    fechaLanzamiento: 'Jan 2024',
    subCategoria: 'GPU',
    marca: 'NVIDIA',
    promedioCalificacion: 4.75,
    totalResenas: 4,
  ),
  Componente(
    id: 'comp-4',
    nombre: 'Memoria RAM Dominator Titanium 32GB DDR5',
    imageAsset: 'assets/images/components/ram_dominator.jpg',
    costo: 189.99,
    consumoEnergetico: 15.0,
    fechaLanzamiento: 'Oct 2023',
    subCategoria: 'RAM',
    marca: 'CORSAIR',
    promedioCalificacion: 4.5,
    totalResenas: 4,
  ),
  Componente(
    id: 'comp-5',
    nombre: 'Disco Duro SSD 990 PRO 2TB NVMe',
    imageAsset: 'assets/images/components/ssd_990pro.jpg',
    costo: 169.99,
    consumoEnergetico: 8.0,
    fechaLanzamiento: 'Nov 2022',
    subCategoria: 'Almacenamiento',
    marca: 'SAMSUNG',
    promedioCalificacion: 4.75,
    totalResenas: 4,
  ),
  Componente(
    id: 'comp-6',
    nombre: 'Fuente de Poder RM850x 80+ Gold',
    imageAsset: 'assets/images/components/psu_rm850x.jpg',
    costo: 129.99,
    consumoEnergetico: 850.0,
    fechaLanzamiento: 'Apr 2021',
    subCategoria: 'PSU',
    marca: 'CORSAIR',
    promedioCalificacion: 4.75,
    totalResenas: 4,
  ),
  Componente(
    id: 'comp-7',
    nombre: 'Placa Base ROG Strix Z790-E Gaming WiFi',
    imageAsset: 'assets/images/components/motherboard_z790e.jpg',
    costo: 499.99,
    consumoEnergetico: 60.0,
    fechaLanzamiento: 'Oct 2022',
    subCategoria: 'Motherboard',
    marca: 'ASUS',
    promedioCalificacion: 4.5,
    totalResenas: 4,
  ),
  Componente(
    id: 'comp-8',
    nombre: 'Enfriamiento Líquido Kraken Elite 360 RGB',
    imageAsset: 'assets/images/components/cooler_kraken.jpg',
    costo: 279.99,
    consumoEnergetico: 25.0,
    fechaLanzamiento: 'Apr 2023',
    subCategoria: 'Cooling',
    marca: 'NZXT',
    promedioCalificacion: 4.75,
    totalResenas: 4,
  ),
];

const sampleResenas = <Resena>[
  Resena(
    id: 'res-101',
    componenteId: 'comp-1',
    nombreUsuario: 'EarlyAdopter',
    fecha: '20 de mayo, 2025',
    calificacion: 4,
    fuente: 'Newegg',
    comentario:
        'Gran rendimiento por el precio, pero hay que esperar a mejores controladores.',
    esCompraVerificada: true,
    authorId: demoUserId,
  ),
  Resena(
    id: 'res-102',
    componenteId: 'comp-1',
    nombreUsuario: 'GamerX',
    fecha: '25 de mayo, 2025',
    calificacion: 5,
    fuente: 'Amazon',
    comentario: 'Tarjeta sólida para jugar a 1440p. Muy recomendada.',
    esCompraVerificada: true,
  ),
  Resena(
    id: 'res-103',
    componenteId: 'comp-1',
    nombreUsuario: 'TechReviewer',
    fecha: '1 de junio, 2025',
    calificacion: 3,
    fuente: 'Best Buy',
    comentario:
        'Funciona un poco más ruidosa de lo esperado bajo carga.',
    esCompraVerificada: false,
  ),
  Resena(
    id: 'res-104',
    componenteId: 'comp-1',
    nombreUsuario: 'BuildMaster',
    fecha: '10 de junio, 2025',
    calificacion: 4,
    fuente: 'Amazon',
    comentario:
        'La eficiencia es impresionante en comparación con la serie 30.',
    esCompraVerificada: true,
  ),
  Resena(
    id: 'res-201',
    componenteId: 'comp-2',
    nombreUsuario: 'CPU_King',
    fecha: '5 de julio, 2025',
    calificacion: 5,
    fuente: 'Micro Center',
    comentario:
        'Increíblemente rápida tanto para productividad como para juegos.',
    esCompraVerificada: true,
    authorId: demoUserId,
  ),
  Resena(
    id: 'res-202',
    componenteId: 'comp-2',
    nombreUsuario: 'VideoEditor99',
    fecha: '12 de julio, 2025',
    calificacion: 5,
    fuente: 'B&H',
    comentario:
        'Los tiempos de renderizado bajaron significativamente. La mejor actualización hasta ahora.',
    esCompraVerificada: true,
  ),
  Resena(
    id: 'res-203',
    componenteId: 'comp-2',
    nombreUsuario: 'BudgetPC',
    fecha: '15 de julio, 2025',
    calificacion: 4,
    fuente: 'Amazon',
    comentario:
        'Necesita un disipador potente, pero el rendimiento es de primer nivel.',
    esCompraVerificada: false,
  ),
  Resena(
    id: 'res-204',
    componenteId: 'comp-2',
    nombreUsuario: 'Overclocker',
    fecha: '20 de julio, 2025',
    calificacion: 5,
    fuente: 'Newegg',
    comentario: 'Maneja el overclocking como un campeón.',
    esCompraVerificada: true,
  ),
  Resena(
    id: 'res-205',
    componenteId: 'comp-2',
    nombreUsuario: 'StandardUser',
    fecha: '25 de julio, 2025',
    calificacion: 5,
    fuente: 'Amazon',
    comentario: 'Estable y rápida.',
    esCompraVerificada: true,
  ),
  Resena(
    id: 'res-1',
    componenteId: 'comp-3',
    nombreUsuario: 'TechWizard92',
    fecha: '12 de marzo, 2024',
    calificacion: 5,
    fuente: 'Newegg',
    comentario:
        'Destruye absolutamente el gaming en 4K. Las temperaturas se mantienen bajas incluso bajo carga pesada.',
    esCompraVerificada: true,
  ),
  Resena(
    id: 'res-2',
    componenteId: 'comp-3',
    nombreUsuario: 'PCBuilder_Mike',
    fecha: '28 de febrero, 2024',
    calificacion: 4,
    fuente: 'Amazon',
    comentario:
        'Gran tarjeta, calienta un poco pero rinde genial. Los controladores son sólidos.',
    esCompraVerificada: true,
  ),
  Resena(
    id: 'res-3',
    componenteId: 'comp-3',
    nombreUsuario: 'GamerDad_TX',
    fecha: '1 de febrero, 2024',
    calificacion: 5,
    fuente: 'Micro Center',
    comentario:
        'Una oferta increíble comparada con la 4090. Lo maneja todo.',
    esCompraVerificada: false,
  ),
  Resena(
    id: 'res-4',
    componenteId: 'comp-3',
    nombreUsuario: 'UltraGamer',
    fecha: '15 de abril, 2024',
    calificacion: 5,
    fuente: 'Amazon',
    comentario:
        'La generación de fotogramas cambia las reglas del juego. Súper fluido.',
    esCompraVerificada: true,
  ),
  Resena(
    id: 'res-401',
    componenteId: 'comp-4',
    nombreUsuario: 'RGB_Enthusiast',
    fecha: '10 de noviembre, 2023',
    calificacion: 5,
    fuente: 'Corsair',
    comentario:
        'La iluminación es hermosa y las velocidades son una locura.',
    esCompraVerificada: true,
  ),
  Resena(
    id: 'res-402',
    componenteId: 'comp-4',
    nombreUsuario: 'StableSystem',
    fecha: '5 de diciembre, 2023',
    calificacion: 4,
    fuente: 'Amazon',
    comentario:
        'El perfil XMP funcionó perfectamente al primer arranque.',
    esCompraVerificada: true,
  ),
  Resena(
    id: 'res-403',
    componenteId: 'comp-4',
    nombreUsuario: 'ValueFinder',
    fecha: '20 de enero, 2024',
    calificacion: 4,
    fuente: 'Newegg',
    comentario: 'Cara pero obtienes lo que pagas en calidad.',
    esCompraVerificada: true,
  ),
  Resena(
    id: 'res-404',
    componenteId: 'comp-4',
    nombreUsuario: 'DDR5_Fan',
    fecha: '15 de febrero, 2024',
    calificacion: 5,
    fuente: 'Amazon',
    comentario:
        'Mejora masiva respecto a mi antigua configuración DDR4.',
    esCompraVerificada: false,
  ),
  Resena(
    id: 'res-501',
    componenteId: 'comp-5',
    nombreUsuario: 'SpeedDemon',
    fecha: '12 de enero, 2023',
    calificacion: 5,
    fuente: 'Samsung',
    comentario:
        'El disco más rápido que he tenido. El SO arranca en segundos.',
    esCompraVerificada: true,
  ),
  Resena(
    id: 'res-502',
    componenteId: 'comp-5',
    nombreUsuario: 'DataHoarder',
    fecha: '28 de febrero, 2023',
    calificacion: 5,
    fuente: 'Amazon',
    comentario:
        'Extremadamente confiable y rápido para transferencias de archivos grandes.',
    esCompraVerificada: true,
  ),
  Resena(
    id: 'res-503',
    componenteId: 'comp-5',
    nombreUsuario: 'GamerLife',
    fecha: '15 de marzo, 2023',
    calificacion: 5,
    fuente: 'Best Buy',
    comentario:
        'Las pantallas de carga prácticamente han desaparecido en la mayoría de los juegos.',
    esCompraVerificada: true,
  ),
  Resena(
    id: 'res-504',
    componenteId: 'comp-5',
    nombreUsuario: 'IT_Pro',
    fecha: '10 de mayo, 2023',
    calificacion: 4,
    fuente: 'Amazon',
    comentario:
        'La actualización de firmware solucionó las preocupaciones iniciales de longevidad. Genial ahora.',
    esCompraVerificada: true,
  ),
  Resena(
    id: 'res-601',
    componenteId: 'comp-6',
    nombreUsuario: 'SilentRig',
    fecha: '20 de junio, 2021',
    calificacion: 5,
    fuente: 'Amazon',
    comentario:
        'El modo de ventilador Zero RPM es ideal para un equipo silencioso.',
    esCompraVerificada: true,
  ),
  Resena(
    id: 'res-602',
    componenteId: 'comp-6',
    nombreUsuario: 'PowerUser',
    fecha: '15 de agosto, 2021',
    calificacion: 5,
    fuente: 'Newegg',
    comentario:
        'Los cables son un poco rígidos pero la calidad no tiene rival.',
    esCompraVerificada: true,
  ),
  Resena(
    id: 'res-603',
    componenteId: 'comp-6',
    nombreUsuario: 'SafetyFirst',
    fecha: '1 de diciembre, 2021',
    calificacion: 5,
    fuente: 'Amazon',
    comentario:
        'La mejor fuente de poder de su clase. Muy eficiente y segura.',
    esCompraVerificada: true,
  ),
  Resena(
    id: 'res-604',
    componenteId: 'comp-6',
    nombreUsuario: 'FirstBuild',
    fecha: '10 de marzo, 2022',
    calificacion: 4,
    fuente: 'Best Buy',
    comentario:
        'Fácil de instalar, el diseño totalmente modular es un salvavidas.',
    esCompraVerificada: false,
  ),
  Resena(
    id: 'res-701',
    componenteId: 'comp-7',
    nombreUsuario: 'ROG_Fanboy',
    fecha: '15 de noviembre, 2022',
    calificacion: 5,
    fuente: 'Asus',
    comentario:
        'Placa base rica en funciones con excelente enfriamiento de VRM.',
    esCompraVerificada: true,
  ),
  Resena(
    id: 'res-702',
    componenteId: 'comp-7',
    nombreUsuario: 'ExtremeOC',
    fecha: '10 de enero, 2023',
    calificacion: 4,
    fuente: 'Micro Center',
    comentario:
        'La BIOS es intuitiva y excelente para el ajuste manual.',
    esCompraVerificada: true,
  ),
  Resena(
    id: 'res-703',
    componenteId: 'comp-7',
    nombreUsuario: 'WorkstationBuild',
    fecha: '5 de marzo, 2023',
    calificacion: 4,
    fuente: 'Amazon',
    comentario:
        'Muchos slots M.2 para todas mis necesidades de almacenamiento.',
    esCompraVerificada: true,
  ),
  Resena(
    id: 'res-704',
    componenteId: 'comp-7',
    nombreUsuario: 'GamerBase',
    fecha: '20 de junio, 2023',
    calificacion: 5,
    fuente: 'Newegg',
    comentario: 'La señal WiFi es fuerte y estable. Hermoso diseño.',
    esCompraVerificada: true,
  ),
  Resena(
    id: 'res-801',
    componenteId: 'comp-8',
    nombreUsuario: 'AIO_Lover',
    fecha: '10 de mayo, 2023',
    calificacion: 5,
    fuente: 'NZXT',
    comentario:
        'La pantalla LCD es nítida y el enfriamiento es excelente.',
    esCompraVerificada: true,
  ),
  Resena(
    id: 'res-802',
    componenteId: 'comp-8',
    nombreUsuario: 'ThermalPaste',
    fecha: '15 de julio, 2023',
    calificacion: 4,
    fuente: 'Amazon',
    comentario:
        'Mantiene mi i9 fresco incluso bajo cargas sintéticas pesadas.',
    esCompraVerificada: true,
  ),
  Resena(
    id: 'res-803',
    componenteId: 'comp-8',
    nombreUsuario: 'CleanBuilds',
    fecha: '1 de septiembre, 2023',
    calificacion: 5,
    fuente: 'Newegg',
    comentario:
        'El software (CAM) ha mejorado mucho. Fácil de sincronizar RGB.',
    esCompraVerificada: true,
  ),
  Resena(
    id: 'res-804',
    componenteId: 'comp-8',
    nombreUsuario: 'TechNerd',
    fecha: '20 de noviembre, 2023',
    calificacion: 5,
    fuente: 'Amazon',
    comentario:
        'Vale su precio premium por la estética y el rendimiento.',
    esCompraVerificada: false,
  ),
];

Componente? componentePorId(String id) {
  for (final componente in sampleComponentes) {
    if (componente.id == id) {
      return componente;
    }
  }
  return null;
}

List<Resena> resenasDe(String componenteId) {
  return sampleResenas
      .where((resena) => resena.componenteId == componenteId)
      .toList(growable: false);
}

double promedioDe(String componenteId) {
  final resenas = resenasDe(componenteId);
  if (resenas.isEmpty) {
    return 0;
  }
  final total = resenas.fold<int>(0, (sum, resena) => sum + resena.calificacion);
  return total / resenas.length;
}

int totalResenasDe(String componenteId) => resenasDe(componenteId).length;

List<String> fuentesDe(String componenteId) {
  final fuentes =
      resenasDe(componenteId).map((resena) => resena.fuente).toSet().toList()
        ..sort();
  return <String>['Todas', ...fuentes];
}

List<String> get categoriasDeComponentes {
  final categorias =
      sampleComponentes.map((componente) => componente.subCategoria).toSet().toList()
        ..sort();
  return <String>['Todo', ...categorias];
}

List<Resena> get resenasDeSiguiendo => <Resena>[
  sampleResenas.firstWhere((resena) => resena.id == 'res-1'),
  sampleResenas.firstWhere((resena) => resena.id == 'res-202'),
  sampleResenas.firstWhere((resena) => resena.id == 'res-401'),
];

List<Resena> get resenasDePerfil => sampleResenas
    .where((resena) => resena.authorId == demoUserId)
    .toList(growable: false);
