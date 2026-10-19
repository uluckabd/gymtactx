import 'package:flutter/material.dart';

/* ===================== TASARIM SABİTLERİ ===================== */

class AppColors {
  static const background = Color(0xFF000000);
  static const card = Color(0xFF1E1E1E);
  static const border = Color(0xFF333333);
  static const primary = Color(0xFFE5FF00);
  static const primaryFaded = Color(0x33E5FF00);
  static const text = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFF9E9E9E);
}

class AppSizes {
  // boşluklar
  static const pagePadding = 16.0;
  static const cardPadding = 16.0;
  static const gapXS = 4.0;
  static const gapS = 8.0;
  static const gapM = 12.0;
  static const gapL = 16.0;
  static const gapXL = 24.0;

  // şekiller
  static const radius = 16.0;
  static const radiusS = 12.0;
  static const radiusFull = 20.0;
  static const borderWidth = 1.0;

  // ikonlar
  static const iconS = 16.0;
  static const icon = 20.0;
  static const iconL = 32.0;

  // diğer
  static const avatar = 56.0;
  static const progressHeight = 8.0;
  static const buttonHeight = 48.0;
  static const chipPaddingH = 12.0;
  static const chipPaddingV = 8.0;
}

class AppStyles {
  static const heading = TextStyle(
    color: AppColors.text,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static const title = TextStyle(
    color: AppColors.text,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static const body = TextStyle(color: AppColors.text, fontSize: 14);
  static const caption = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 12,
  );
  static const accent = TextStyle(color: AppColors.primary, fontSize: 12);
  static const price = TextStyle(
    color: AppColors.primary,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static const display = TextStyle(
    color: AppColors.primary,
    fontSize: 36,
    fontWeight: FontWeight.bold,
  );
  static const value = TextStyle(
    color: AppColors.text,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
}

class AppFormat {
  static String date(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}.${d.month.toString().padLeft(2, '0')}.${d.year}';

  static String price(int value) =>
      '₺${value.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => '.')}';
}

/* ===================== MODELLER (API'DEN DOLACAK) ===================== */

class GymInfo {
  final String name;
  final String address;
  final String phone;
  final String hours;

  const GymInfo({
    required this.name,
    required this.address,
    required this.phone,
    required this.hours,
  });
}

class Membership {
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;

  const Membership({
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.isActive,
  });

  int get remainingDays => endDate.difference(DateTime.now()).inDays;

  double get progress {
    final total = endDate.difference(startDate).inDays;
    final passed = DateTime.now().difference(startDate).inDays;
    return (passed / total).clamp(0.0, 1.0);
  }
}

class GymStats {
  final int totalMembers;
  final int trainerCount;

  const GymStats({required this.totalMembers, required this.trainerCount});
}

class MembershipPackage {
  final String name;
  final String subtitle;
  final int price;
  final bool isFeatured;

  const MembershipPackage({
    required this.name,
    required this.subtitle,
    required this.price,
    this.isFeatured = false,
  });
}

class Trainer {
  final String name;
  final String field;
  final int experienceYears;

  const Trainer({
    required this.name,
    required this.field,
    required this.experienceYears,
  });
}

class Amenity {
  final IconData icon;
  final String label;

  const Amenity({required this.icon, required this.label});
}

/* ===================== SAHTE VERİ ===================== */

class MockData {
  static const gym = GymInfo(
    name: 'GYMTACTX FITNESS CLUB',
    address: 'Merkez Şube · Konum bilgisi',
    phone: '+90 5XX XXX XX XX',
    hours: '15.00-24.00',
  );

  static final membership = Membership(
    name: '6 Aylık Premium',
    startDate: DateTime(2026, 9, 1),
    endDate: DateTime(2027, 3, 1),
    isActive: true,
  );

  static const stats = GymStats(totalMembers: 1248, trainerCount: 3);

  static const packages = [
    MembershipPackage(
      name: 'Standart',
      subtitle: '1 Ay · Fitness alanına erişim',
      price: 1200,
    ),
    MembershipPackage(
      name: 'Avantaj',
      subtitle: '3 Ay · Fitness + grup dersleri',
      price: 3000,
      isFeatured: true,
    ),
    MembershipPackage(
      name: 'Premium',
      subtitle: '12 Ay · Tüm alanlar + özel avantajlar',
      price: 9600,
    ),
  ];

  static const trainers = [
    Trainer(
      name: 'Mert Yılmaz',
      field: 'Kuvvet ve kondisyon',
      experienceYears: 6,
    ),
    Trainer(
      name: 'Ece Demir',
      field: 'Fonksiyonel antrenman',
      experienceYears: 5,
    ),
    Trainer(name: 'Can Arslan', field: 'Vücut geliştirme', experienceYears: 8),
  ];

  static const amenities = [
    Amenity(icon: Icons.shower_outlined, label: 'Duş'),
    Amenity(icon: Icons.wifi, label: 'Wi-Fi'),
    Amenity(icon: Icons.lock_outline, label: 'Dolap'),
    Amenity(icon: Icons.local_parking, label: 'Otopark'),
    Amenity(icon: Icons.groups_outlined, label: 'Grup dersleri'),
    Amenity(icon: Icons.fitness_center, label: 'Serbest ağırlık'),
  ];
}

/* ===================== ORTAK WIDGETLAR ===================== */

class AppIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color color;

  const AppIcon(
    this.icon, {
    super.key,
    this.size = AppSizes.icon,
    this.color = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) => Icon(icon, size: size, color: color);
}

class AppText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign? align;

  const AppText.heading(this.text, {super.key, this.align})
    : style = AppStyles.heading;
  const AppText.title(this.text, {super.key, this.align})
    : style = AppStyles.title;
  const AppText.body(this.text, {super.key, this.align})
    : style = AppStyles.body;
  const AppText.caption(this.text, {super.key, this.align})
    : style = AppStyles.caption;
  const AppText.accent(this.text, {super.key, this.align})
    : style = AppStyles.accent;
  const AppText.price(this.text, {super.key, this.align})
    : style = AppStyles.price;
  const AppText.display(this.text, {super.key, this.align})
    : style = AppStyles.display;
  const AppText.value(this.text, {super.key, this.align})
    : style = AppStyles.value;

  @override
  Widget build(BuildContext context) =>
      Text(text, style: style, textAlign: align);
}

class AppCard extends StatelessWidget {
  final Widget child;
  final Color color;
  final Color borderColor;
  final VoidCallback? onTap;

  const AppCard({
    super.key,
    required this.child,
    this.color = AppColors.card,
    this.borderColor = AppColors.border,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.radius),
      side: BorderSide(color: borderColor, width: AppSizes.borderWidth),
    );
    return Material(
      color: color,
      shape: shape,
      child: InkWell(
        customBorder: shape,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.cardPadding),
          child: SizedBox(width: double.infinity, child: child),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;

  const SectionTitle({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      AppIcon(icon),
      const SizedBox(width: AppSizes.gapS),
      AppText.title(title),
    ],
  );
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      AppIcon(icon, size: AppSizes.iconS),
      const SizedBox(width: AppSizes.gapS),
      AppText.body(text),
    ],
  );
}

class AppBadge extends StatelessWidget {
  final String text;

  const AppBadge(this.text, {super.key});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(
      horizontal: AppSizes.chipPaddingH,
      vertical: AppSizes.gapXS,
    ),
    decoration: BoxDecoration(
      color: AppColors.primaryFaded,
      borderRadius: BorderRadius.circular(AppSizes.radiusFull),
    ),
    child: AppText.accent(text),
  );
}

class AppOutlinedButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  const AppOutlinedButton({
    super.key,
    required this.icon,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    height: AppSizes.buttonHeight,
    child: OutlinedButton.icon(
      onPressed: onPressed,
      icon: const AppIcon(Icons.ac_unit, size: AppSizes.icon),
      label: Text(label, style: AppStyles.accent.copyWith(fontSize: 14)),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radius),
        ),
      ),
    ),
  );
}

/* ===================== BÖLÜM WIDGETLARI ===================== */

class GymHeaderCard extends StatelessWidget {
  final GymInfo gym;

  const GymHeaderCard({super.key, required this.gym});

  @override
  Widget build(BuildContext context) => AppCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: AppText.heading(gym.name)),
            const AppIcon(Icons.fitness_center, size: AppSizes.iconL),
          ],
        ),
        const SizedBox(height: AppSizes.gapM),
        InfoRow(icon: Icons.location_on_outlined, text: gym.address),
        const SizedBox(height: AppSizes.gapS),
        InfoRow(icon: Icons.phone_outlined, text: gym.phone),
        const SizedBox(height: AppSizes.gapS),
        InfoRow(icon: Icons.access_time, text: gym.hours),
      ],
    ),
  );
}

class _DateColumn extends StatelessWidget {
  final String label;
  final DateTime date;

  const _DateColumn({required this.label, required this.date});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AppText.caption(label),
      const SizedBox(height: AppSizes.gapXS),
      AppText.body(AppFormat.date(date)),
    ],
  );
}

class MembershipCard extends StatelessWidget {
  final Membership membership;

  const MembershipCard({super.key, required this.membership});

  @override
  Widget build(BuildContext context) => AppCard(
    borderColor: AppColors.primaryFaded,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText.title(membership.name),
            AppBadge(membership.isActive ? 'Aktif' : 'Pasif'),
          ],
        ),
        const SizedBox(height: AppSizes.gapM),
        Row(
          children: [
            Expanded(
              child: _DateColumn(
                label: 'Başlangıç',
                date: membership.startDate,
              ),
            ),
            Expanded(
              child: _DateColumn(label: 'Bitiş', date: membership.endDate),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.gapM),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            AppText.display('${membership.remainingDays}'),
            const SizedBox(width: AppSizes.gapS),
            const AppText.caption('gün kaldı'),
          ],
        ),
        const SizedBox(height: AppSizes.gapS),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.radiusFull),
          child: LinearProgressIndicator(
            value: membership.progress,
            minHeight: AppSizes.progressHeight,
            color: AppColors.primary,
            backgroundColor: AppColors.border,
          ),
        ),
        const SizedBox(height: AppSizes.gapL),
        AppOutlinedButton(
          icon: Icons.ac_unit,
          label: 'Üyeliği Dondur',
          onPressed: () {},
        ),
      ],
    ),
  );
}

class StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const StatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) => AppCard(
    child: Column(
      children: [
        AppIcon(icon),
        const SizedBox(height: AppSizes.gapS),
        AppText.value(value),
        const SizedBox(height: AppSizes.gapXS),
        AppText.caption(label),
      ],
    ),
  );
}

class PackageCard extends StatelessWidget {
  final MembershipPackage package;

  const PackageCard({super.key, required this.package});

  @override
  Widget build(BuildContext context) => AppCard(
    borderColor: package.isFeatured ? AppColors.primary : AppColors.border,
    onTap: () {},
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AppText.title(package.name),
                  if (package.isFeatured) ...[
                    const SizedBox(width: AppSizes.gapS),
                    const AppIcon(Icons.star, size: AppSizes.iconS),
                  ],
                ],
              ),
              const SizedBox(height: AppSizes.gapXS),
              AppText.caption(package.subtitle),
            ],
          ),
        ),
        AppText.price(AppFormat.price(package.price)),
      ],
    ),
  );
}

class TrainerCard extends StatelessWidget {
  final Trainer trainer;

  const TrainerCard({super.key, required this.trainer});

  @override
  Widget build(BuildContext context) => AppCard(
    onTap: () {},
    child: Row(
      children: [
        Container(
          width: AppSizes.avatar,
          height: AppSizes.avatar,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(AppSizes.radiusS),
          ),
          child: const AppIcon(Icons.person_outline, size: AppSizes.iconL),
        ),
        const SizedBox(width: AppSizes.gapM),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.title(trainer.name),
              const SizedBox(height: AppSizes.gapXS),
              AppText.caption(trainer.field),
              const SizedBox(height: AppSizes.gapXS),
              AppText.accent('${trainer.experienceYears} yıl deneyim'),
            ],
          ),
        ),
        const AppIcon(Icons.chevron_right, color: AppColors.textSecondary),
      ],
    ),
  );
}

class AmenityChip extends StatelessWidget {
  final Amenity amenity;

  const AmenityChip({super.key, required this.amenity});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(
      horizontal: AppSizes.chipPaddingH,
      vertical: AppSizes.chipPaddingV,
    ),
    decoration: BoxDecoration(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(AppSizes.radiusS),
      border: Border.all(color: AppColors.border, width: AppSizes.borderWidth),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppIcon(amenity.icon, size: AppSizes.iconS),
        const SizedBox(width: AppSizes.gapS),
        AppText.body(amenity.label),
      ],
    ),
  );
}

/* ===================== SAYFA ===================== */

class MyGymPage extends StatelessWidget {
  const MyGymPage({super.key});

  @override
  Widget build(BuildContext context) {
    const gym = MockData.gym;
    final membership = MockData.membership;
    const stats = MockData.stats;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: const AppText.heading('Salonum'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.pagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(icon: Icons.info_outline, title: 'salon bilgileri'),
            const SizedBox(height: AppSizes.gapM),
            const GymHeaderCard(gym: gym),
            const SizedBox(height: AppSizes.gapL),
            const SectionTitle(
              icon: Icons.workspace_premium_outlined,
              title: 'Üyeliğim',
            ),
            const SizedBox(height: AppSizes.gapL),
            MembershipCard(membership: membership),
            const SizedBox(height: AppSizes.gapL),
            const SectionTitle(
              icon: Icons.bar_chart,
              title: 'Salon istatistikleri',
            ),
            const SizedBox(height: AppSizes.gapL),
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    icon: Icons.groups_outlined,
                    value: '${stats.totalMembers}',
                    label: 'Toplam üye',
                  ),
                ),
                const SizedBox(width: AppSizes.gapL),
                Expanded(
                  child: StatCard(
                    icon: Icons.sports_martial_arts,
                    value: '${stats.trainerCount}',
                    label: 'Antrenör',
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.gapL),
            const SectionTitle(
              icon: Icons.sell_outlined,
              title: 'Üyelik paketleri',
            ),
            const SizedBox(height: AppSizes.gapL),
            ...MockData.packages.map(
              (p) => Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.gapM),
                child: PackageCard(package: p),
              ),
            ),
            const SizedBox(height: AppSizes.gapL),

            const SectionTitle(
              icon: Icons.badge_outlined,
              title: 'Antrenörlerimiz',
            ),
            const SizedBox(height: AppSizes.gapM),
            ...MockData.trainers.map(
              (t) => Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.gapM),
                child: TrainerCard(trainer: t),
              ),
            ),
            const SizedBox(height: AppSizes.gapS),

            const SectionTitle(
              icon: Icons.grid_view,
              title: 'Salon olanakları',
            ),
            const SizedBox(height: AppSizes.gapM),
            Wrap(
              spacing: AppSizes.gapS,
              runSpacing: AppSizes.gapS,
              children: MockData.amenities
                  .map((a) => AmenityChip(amenity: a))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
