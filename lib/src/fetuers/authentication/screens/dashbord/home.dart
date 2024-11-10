import 'dart:convert'; // For JSON encoding/decoding
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // For making HTTP requests
import 'package:cricket/src/constants/colors.dart';
import 'package:cricket/src/common_widget/user_dashbord_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;
  List<dynamic> _liveMatches = [];
  bool _isLoading = true;
  String _apiUrl =
      'https://api.example.com/live-scores'; // Replace with your API URL

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateScrollOffset);
    _fetchLiveScores();
  }

  void _updateScrollOffset() {
    setState(() {
      _scrollOffset = _scrollController.offset;
    });
  }

  Future<void> _fetchLiveScores() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          _liveMatches = json.decode(response.body);
          _isLoading = false;
        });
      } else {
        // Handle the error
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      // Handle exceptions
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateScrollOffset);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // Smart animated header
          SliverToBoxAdapter(
            child: UserDashboardHeader(shrinkOffset: _scrollOffset),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 16, 5, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Horizontally scrollable card list for live matches
                  SizedBox(
                    height: 210,
                    child: _isLoading
                        ? Center(child: CircularProgressIndicator())
                        : _liveMatches.isEmpty
                            ? Center(child: Text('No live matches'))
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _liveMatches.length,
                                itemBuilder: (context, index) {
                                  final matchData = _liveMatches[index];
                                  return Container(
                                    width: 400, // Adjust width as needed
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 102, 11, 6),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // First row: Match type and status
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                matchData['matchType'] ??
                                                    'Unknown',
                                                style: const TextStyle(
                                                  color: lightColor,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                matchData['status'] ?? 'Live',
                                                style: const TextStyle(
                                                  color: lightColor,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 12),
                                          // Second row: Country details for team1
                                          Row(
                                            children: [
                                              // Placeholder for team1 image or flag
                                              Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: lightColor,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.flag,
                                                    color: darkColor,
                                                    size: 24,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              // Team1 name
                                              Text(
                                                matchData['team1'] ?? 'Team1',
                                                style: const TextStyle(
                                                  color: lightColor,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              const Spacer(),
                                              // Match stats for team1
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    matchData['team1Score'] ??
                                                        '0/0',
                                                    style: const TextStyle(
                                                      color: lightColor,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Text(
                                                    '(${matchData['team1Overs'] ?? 0})',
                                                    style: TextStyle(
                                                      color: lightColor
                                                          .withOpacity(0.7),
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 12),
                                          // Third row: Second team (team2) details
                                          Row(
                                            children: [
                                              // Placeholder for team2 image or flag
                                              Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: lightColor,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.flag,
                                                    color: darkColor,
                                                    size: 24,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              // Team2 name
                                              Text(
                                                matchData['team2'] ?? 'Team2',
                                                style: const TextStyle(
                                                  color: lightColor,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              const Spacer(),
                                              // Match stats for team2
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    matchData['team2Score'] ??
                                                        '0/0',
                                                    style: const TextStyle(
                                                      color: lightColor,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Text(
                                                    '(${matchData['team2Overs'] ?? 0})',
                                                    style: TextStyle(
                                                      color: lightColor
                                                          .withOpacity(0.7),
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 12),
                                          // Fourth row: Target or current match status
                                          Text(
                                            matchData['target'] ??
                                                'No target set',
                                            style: const TextStyle(
                                              color: lightColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Recommended for you',
                    style: TextStyle(
                      color: lightColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Non-scrollable card list for scheduled matches
                  Column(
                    children: List.generate(
                      10, // Replace with actual number of scheduled matches
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 0),
                        decoration: BoxDecoration(
                          color: lightColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12.0),
                          title: Text(
                            'Scheduled Match ${index + 1}', // Replace with scheduled match data
                            style: const TextStyle(
                              color: darkColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: const Text(
                            'Details of the match', // Replace with match details
                            style: TextStyle(
                              color: darkColor,
                              fontSize: 16,
                            ),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios,
                              color: darkColor),
                          onTap: () {
                            // Handle tap event
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


