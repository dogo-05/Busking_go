import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 32),
                // 프로필 섹션
                _buildProfileSection(),
                const SizedBox(height: 24),
                // 메뉴 리스트
                _buildMenuList(context),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Column(
      children: [
        const AppAvatar(
          emoji: '😊',
          size: 120,
          borderRadius: 40,
        ),
        const SizedBox(height: 20),
        const Text(
          '김민수',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          '일반 회원',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 28),
        // 통계
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStatItem('127', '공연횟수'),
            const SizedBox(width: 24),
            _buildStatItem('1.2K', '팔로워'),
            const SizedBox(width: 24),
            _buildStatItem('4.9', '평점'),
          ],
        ),
      ],
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuList(BuildContext context) {
    return Column(
      children: [
        MenuItem(
          icon: '📝',
          label: '프로필 수정',
          iconBackgroundColor: AppColors.pastelPink,
          onTap: () {},
        ),
        const SizedBox(height: 10),
        MenuItem(
          icon: '📍',
          label: '나의 버스킹 이력',
          iconBackgroundColor: AppColors.pastelBlue,
          onTap: () {},
        ),
        const SizedBox(height: 10),
        MenuItem(
          icon: '❤️',
          label: '찜한 버스커',
          iconBackgroundColor: AppColors.pastelMint,
          onTap: () {},
        ),
        const SizedBox(height: 10),
        MenuItem(
          icon: '⚙️',
          label: '설정',
          iconBackgroundColor: AppColors.pastelYellow,
          onTap: () {},
        ),
      ],
    );
  }
}
