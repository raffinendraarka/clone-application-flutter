import 'package:flutter/material.dart';
import '../data/movie_data.dart';
import '../theme/app_theme.dart';
import 'netflix_logo.dart';

/// Navigation Bar Netflix Desktop & Responsif.
///
/// Menampilkan:
/// - Netflix Logo
/// - Menu: Home, TV Shows, Movies, New & Popular, My List
/// - Search Icon, Notification Icon
/// - Profile Avatar & Nama Pengguna: Arka Raffinendra
/// - Tombol Logout (navigasi kembali ke Login Page)
class NetflixNavbar extends StatefulWidget {
  final bool isScrolled;
  final String activeTab;
  final ValueChanged<String> onTabSelected;
  final VoidCallback onLogout;
  final VoidCallback onSearchTap;
  final VoidCallback onNotificationTap;

  const NetflixNavbar({
    super.key,
    required this.isScrolled,
    required this.activeTab,
    required this.onTabSelected,
    required this.onLogout,
    required this.onSearchTap,
    required this.onNotificationTap,
  });

  static const List<String> navItems = <String>[
    'Home',
    'TV Shows',
    'Movies',
    'New & Popular',
    'My List',
  ];

  @override
  State<NetflixNavbar> createState() => _NetflixNavbarState();
}

class _NetflixNavbarState extends State<NetflixNavbar> {
  String? _hoveredTab;
  bool _logoutHovered = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth >= 1100;
    final bool isMobile = screenWidth < 700;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
      height: isMobile ? 64 : 70,
      decoration: BoxDecoration(
        color: widget.isScrolled
            ? AppTheme.primaryBackground.withValues(alpha: 0.97)
            : Colors.transparent,
        gradient: widget.isScrolled
            ? null
            : const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color(0xDE000000),
                  Color(0x77000000),
                  Colors.transparent,
                ],
              ),
        boxShadow: widget.isScrolled
            ? const <BoxShadow>[
                BoxShadow(
                  color: Color(0x88000000),
                  blurRadius: 14,
                  offset: Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 12 : (isDesktop ? 48 : 24),
        ),
        child: Row(
          children: <Widget>[
            // 1. Netflix Logo
            NetflixLogo(
              fontSize: isMobile ? 20 : 28,
              onTap: () => widget.onTabSelected('Home'),
            ),
            SizedBox(width: isMobile ? 8 : 32),

            // 2. Menu Navigasi (Desktop Row / Mobile Dropdown)
            if (isDesktop)
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: NetflixNavbar.navItems.map((String item) {
                      final bool isActive = widget.activeTab == item;
                      final bool isHovered = _hoveredTab == item;

                      return Padding(
                        padding: const EdgeInsets.only(right: 18),
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          onEnter: (_) => setState(() => _hoveredTab = item),
                          onExit: (_) => setState(() => _hoveredTab = null),
                          child: GestureDetector(
                            onTap: () => widget.onTabSelected(item),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 180),
                                  style: TextStyle(
                                    color: isActive
                                        ? AppTheme.primaryText
                                        : (isHovered
                                            ? AppTheme.primaryText
                                                .withValues(alpha: 0.85)
                                            : AppTheme.secondaryText),
                                    fontSize: 14,
                                    fontWeight: isActive
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                  ),
                                  child: Text(item),
                                ),
                                const SizedBox(height: 4),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 220),
                                  height: 2.5,
                                  width: isActive ? 22 : (isHovered ? 12 : 0),
                                  decoration: BoxDecoration(
                                    color: isActive
                                        ? AppTheme.netflixRed
                                        : AppTheme.secondaryText,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              )
            else
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: PopupMenuButton<String>(
                    tooltip: 'Browse Menu',
                    color: AppTheme.secondaryBackground,
                    offset: const Offset(0, 44),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                      side: const BorderSide(color: AppTheme.borderColor),
                    ),
                    onSelected: widget.onTabSelected,
                    itemBuilder: (BuildContext context) {
                      return NetflixNavbar.navItems.map((String item) {
                        final bool isSelected = widget.activeTab == item;
                        return PopupMenuItem<String>(
                          value: item,
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 4,
                                height: 18,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppTheme.netflixRed
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                item,
                                style: TextStyle(
                                  color: isSelected
                                      ? AppTheme.primaryText
                                      : AppTheme.secondaryText,
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList();
                    },
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.45),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: AppTheme.borderColor.withValues(alpha: 0.7),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              widget.activeTab,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppTheme.primaryText,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.arrow_drop_down,
                              color: AppTheme.primaryText,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            // 3. Search Icon
            SizedBox(
              width: isMobile ? 34 : 40,
              height: isMobile ? 34 : 40,
              child: IconButton(
                tooltip: 'Search',
                padding: EdgeInsets.zero,
                style: IconButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: widget.onSearchTap,
                icon: Icon(
                  Icons.search_rounded,
                  color: AppTheme.primaryText,
                  size: isMobile ? 21 : 24,
                ),
              ),
            ),

            SizedBox(width: isMobile ? 2 : 8),

            // 4. Notification Icon
            SizedBox(
              width: isMobile ? 34 : 40,
              height: isMobile ? 34 : 40,
              child: IconButton(
                tooltip: 'Notifications',
                padding: EdgeInsets.zero,
                style: IconButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: widget.onNotificationTap,
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Icon(
                      Icons.notifications_none_rounded,
                      color: AppTheme.primaryText,
                      size: isMobile ? 21 : 24,
                    ),
                    Positioned(
                      right: 1,
                      top: 1,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppTheme.netflixRed,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(width: isMobile ? 4 : 10),

            // 5. Profile Avatar & Nama Pengguna: Arka Raffinendra (dengan Dropdown Profil)
            PopupMenuButton<String>(
              tooltip: 'Profile: ${MovieData.currentUserName}',
              color: AppTheme.secondaryBackground,
              offset: const Offset(0, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
                side: const BorderSide(color: AppTheme.borderColor),
              ),
              onSelected: (String value) {
                if (value == 'logout') {
                  widget.onLogout();
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  enabled: false,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: AppTheme.netflixRed,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'A',
                          style: TextStyle(
                            color: AppTheme.primaryText,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              MovieData.currentUserName,
                              style: TextStyle(
                                color: AppTheme.primaryText,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'Netflix Premium Member',
                              style: TextStyle(
                                color: AppTheme.secondaryText,
                                fontSize: 11.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem<String>(
                  value: 'logout',
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.logout_rounded,
                        color: AppTheme.netflixRed,
                        size: 18,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Sign out of Netflix',
                        style: TextStyle(
                          color: AppTheme.primaryText,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppTheme.netflixRed,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'A',
                        style: TextStyle(
                          color: AppTheme.primaryText,
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    if (!isMobile) ...<Widget>[
                      const SizedBox(width: 8),
                      const Text(
                        MovieData.currentUserName,
                        style: TextStyle(
                          color: AppTheme.primaryText,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_drop_down,
                        color: AppTheme.primaryText,
                        size: 18,
                      ),
                    ],
                  ],
                ),
              ),
            ),

            SizedBox(width: isMobile ? 4 : 10),

            // 6. Tombol Logout Langsung menuju Login Page
            MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) => setState(() => _logoutHovered = true),
              onExit: (_) => setState(() => _logoutHovered = false),
              child: Tooltip(
                message: 'Logout to Login Page',
                child: InkWell(
                  onTap: widget.onLogout,
                  borderRadius: BorderRadius.circular(4),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 8 : 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: _logoutHovered
                          ? AppTheme.hoverRed
                          : AppTheme.netflixRed.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Icon(
                          Icons.logout_rounded,
                          color: AppTheme.primaryText,
                          size: 16,
                        ),
                        if (!isMobile) ...<Widget>[
                          const SizedBox(width: 6),
                          const Text(
                            'Logout',
                            style: TextStyle(
                              color: AppTheme.primaryText,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
