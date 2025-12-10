import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart' hide SearchBar;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController? _mapController;
  bool showInfoCard = true;
  int selectedMarkerIndex = 0;

  // 천안 신부동 초기 위치
  static const LatLng _initialPosition = LatLng(36.8185, 127.1555);

  // 버스킹 위치 데이터 (천안 신부동 기반)
  final List<BuskingData> _buskingSpots = [
    BuskingData(
      id: '1',
      position: const LatLng(36.8194, 127.1562),
      name: '기타리스트 준호',
      location: '신세계백화점 천안아산점 앞',
      genre: '어쿠스틱',
      time: '18:00~',
      status: '버스킹 중',
      emoji: '🎸',
    ),
    BuskingData(
      id: '2',
      position: const LatLng(36.8180, 127.1556),
      name: '보컬리스트 수진',
      location: '신부문화공원',
      genre: '발라드',
      time: '19:00~',
      status: '예정됨',
      emoji: '🎤',
    ),
    BuskingData(
      id: '3',
      position: const LatLng(36.8188, 127.1548),
      name: '재즈밴드 블루노트',
      location: '다이소 천안본점',
      genre: '재즈',
      time: '20:00~',
      status: '버스킹 중',
      emoji: '🎺',
    ),
  ];

  Set<Marker> _createMarkers() {
    return _buskingSpots.asMap().entries.map((entry) {
      final index = entry.key;
      final spot = entry.value;
      return Marker(
        markerId: MarkerId(spot.id),
        position: spot.position,
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueRose,
        ),
        onTap: () {
          setState(() {
            selectedMarkerIndex = index;
            showInfoCard = true;
          });
        },
      );
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 구글 지도
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: _initialPosition,
              zoom: 15,
            ),
            onMapCreated: (controller) {
              _mapController = controller;
            },
            markers: _createMarkers(),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            onTap: (_) {
              setState(() {
                showInfoCard = false;
              });
            },
          ),

          // 검색바
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            right: 16,
            child: _buildSearchBar(),
          ),

          // 현재 위치 버튼
          Positioned(
            right: 16,
            bottom: showInfoCard ? 200 : 100,
            child: _buildMyLocationButton(),
          ),

          // 버스킹 정보 카드
          if (showInfoCard)
            Positioned(
              bottom: 20,
              left: 16,
              right: 16,
              child: _buildBuskingInfoCard(_buskingSpots[selectedMarkerIndex]),
            ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Text('🔍', style: TextStyle(fontSize: 18)),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: '버스킹 장소 검색',
                hintStyle: const TextStyle(color: AppColors.textLight),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyLocationButton() {
    return GestureDetector(
      onTap: () {
        _mapController?.animateCamera(
          CameraUpdate.newLatLng(_initialPosition),
        );
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(
          Icons.my_location,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildBuskingInfoCard(BuskingData data) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.2),
            blurRadius: 30,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              AppAvatar(emoji: data.emoji, size: 60, borderRadius: 18),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data.location,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              ),
              // 찜하기 버튼
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.pastelPink.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.favorite_border,
                    color: AppColors.primary,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              AppTag.pink(data.genre),
              const SizedBox(width: 8),
              AppTag.blue(data.time),
              const SizedBox(width: 8),
              AppTag.mint(data.status),
            ],
          ),
        ],
      ),
    );
  }
}

class BuskingData {
  final String id;
  final LatLng position;
  final String name;
  final String location;
  final String genre;
  final String time;
  final String status;
  final String emoji;

  BuskingData({
    required this.id,
    required this.position,
    required this.name,
    required this.location,
    required this.genre,
    required this.time,
    required this.status,
    required this.emoji,
  });
}
