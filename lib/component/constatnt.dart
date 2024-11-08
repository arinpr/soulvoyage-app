import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF555AE2);
const kBorderColor = Color(0xFFDEE2E6);
const kTextColor = Color(0xFF212529);
const kButtonColor = Color(0xFF0D6EFD);
const kButton= Color(0xFF16169F);
const kQuestion = Color(0xFF716969);
const kOrange = Color(0xFFFFD580);
const kPageColor = Color.fromARGB(255, 244, 241, 252);
const kFirst = Color.fromARGB(255, 186, 188, 207);

//api url 

const apiUrl = "https://backend.soulvoyage.tech/";
const loginAPI = "${apiUrl}api/auth/login";
const registerAPI = "${apiUrl}addUser";
const journalEntry = "${apiUrl}addJournal";
const allEntries = "${apiUrl}getAllJournalEntries";
const deleteEntries = "${apiUrl}deleteJournal";
const journalEntryUpdate = "${apiUrl}updateJournal";
