import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import 'map_picker_screen.dart';

class RegisterScheduleScreen extends StatefulWidget {
  const RegisterScheduleScreen({super.key});

  @override
  State<RegisterScheduleScreen> createState() => _RegisterScheduleScreenState();
}

class _RegisterScheduleScreenState extends State<RegisterScheduleScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime selectedDate = DateTime(2025, 12, 15);
  String startTime = '18:00';
  String endTime = '20:00';
  Set<String> selectedGenres = {'어쿠스틱'};
  LatLng? selectedLocation;
  String locationText = '지도에서 위치 선택';

  final List<String> genres = [
    '어쿠스틱',
    '밴드',
    '재즈',
    '클래식',
    '힙합',
    '댄스',
    '마술',
    '기타',
  ];

  final List<String> timeOptions = [
    '14:00',
    '15:00',
    '16:00',
    '17:00',
    '18:00',
    '19:00',
    '20:00',
    '21:00',
    '22:00',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 헤더
              _buildHeader(),
              // 폼
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      _buildSection(
                        icon: '🎵',
                        title: '공연 제목',
                        child: TextField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            hintText: '공연 제목을 입력하세요',
                          ),
                        ),
                      ),
                      _buildSection(
                        icon: '📅',
                        title: '날짜 및 시간',
                        child: _buildDateTimeSelector(),
                      ),
                      _buildSection(
                        icon: '📍',
                        title: '공연 장소',
                        child: _buildLocationSelector(),
                      ),
                      _buildSection(
                        icon: '🎸',
                        title: '장르',
                        child: _buildGenreSelector(),
                      ),
                      _buildSection(
                        icon: '📝',
                        title: '공연 소개',
                        child: TextField(
                          controller: _descriptionController,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            hintText: '공연에 대한 간단한 소개를 작성해주세요',
                          ),
                        ),
                      ),
                      _buildNotice(),
                      const SizedBox(height: 20),
                      GradientButton(
                        text: '등록 신청',
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        children: [
          const AppBackButton(),
          const Expanded(
            child: Text(
              '버스킹 일정 등록',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(width: 44),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String icon,
    required String title,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildDateTimeSelector() {
    return Column(
      children: [
        // 날짜 선택
        GestureDetector(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: selectedDate,
              firstDate: DateTime.now(),
              lastDate: DateTime(2026),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: AppColors.primary,
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (date != null) {
              setState(() {
                selectedDate = date;
              });
            }
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.border, width: 2),
            ),
            child: Text(
              '${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일',
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        // 시간 선택
        Row(
          children: [
            Expanded(
              child: _buildTimeDropdown(
                value: startTime,
                hint: '시작 시간',
                onChanged: (value) {
                  setState(() {
                    startTime = value!;
                  });
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTimeDropdown(
                value: endTime,
                hint: '종료 시간',
                onChanged: (value) {
                  setState(() {
                    endTime = value!;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimeDropdown({
    required String value,
    required String hint,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border, width: 2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textLight),
          style: const TextStyle(
            fontSize: 15,
            color: AppColors.textPrimary,
          ),
          items: timeOptions.map((time) {
            return DropdownMenuItem(
              value: time,
              child: Text(time),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildLocationSelector() {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push<LatLng>(
          context,
          MaterialPageRoute(
            builder: (_) => MapPickerScreen(initialPosition: selectedLocation),
          ),
        );
        if (result != null) {
          setState(() {
            selectedLocation = result;
            locationText = '선택됨: ${result.latitude.toStringAsFixed(4)}, ${result.longitude.toStringAsFixed(4)}';
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.border, width: 2),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.pastelMint,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Center(
                child: Text('🗺️', style: TextStyle(fontSize: 20)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    locationText,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: selectedLocation != null
                          ? AppColors.success
                          : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    selectedLocation != null
                        ? '탭하여 위치 변경'
                        : '탭하여 버스킹 장소를 지정하세요',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.textLight,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenreSelector() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: genres.map((genre) {
        final isSelected = selectedGenres.contains(genre);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                selectedGenres.remove(genre);
              } else {
                selectedGenres.add(genre);
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? null : AppColors.cardBackground,
              gradient: isSelected
                  ? const LinearGradient(
                      colors: [Color(0xFFFFF5F6), Colors.white],
                    )
                  : null,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? AppColors.pastelPink : AppColors.border,
                width: 2,
              ),
            ),
            child: Text(
              genre,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.primary : AppColors.textPrimary,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildNotice() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFF5F6), Color(0xFFF5F8FF)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '안내: ',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
            TextSpan(
              text: '등록된 일정은 관리자 승인 후 지도에 표시됩니다. 승인까지 최대 24시간이 소요될 수 있습니다.',
              style: TextStyle(
                color: AppColors.textLight,
              ),
            ),
          ],
        ),
        style: TextStyle(
          fontSize: 13,
          height: 1.6,
        ),
      ),
    );
  }
}
