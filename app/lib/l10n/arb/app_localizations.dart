import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'arb/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// Text shown in the AppBar of the Counter Page
  ///
  /// In en, this message translates to:
  /// **'Counter'**
  String get counterAppBarTitle;

  /// Title for the biometrics dashboard page
  ///
  /// In en, this message translates to:
  /// **'Biometrics Dashboard'**
  String get biometricsDashboardTitle;

  /// Title shown when no biometric data is available
  ///
  /// In en, this message translates to:
  /// **'No Data Available'**
  String get noDataAvailable;

  /// Description shown when no biometric data is available
  ///
  /// In en, this message translates to:
  /// **'There is no biometric data to display at the moment.'**
  String get noDataAvailableDescription;

  /// Title shown when an error occurs
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// Text for retry button
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Default error message when no specific error is provided
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get anErrorOccurred;

  /// HRV average label with period placeholder
  ///
  /// In en, this message translates to:
  /// **'HRV Avg ({period})'**
  String hrvAvg(String period);

  /// RHR average label with period placeholder
  ///
  /// In en, this message translates to:
  /// **'RHR Avg ({period})'**
  String rhrAvg(String period);

  /// Steps total label with period placeholder
  ///
  /// In en, this message translates to:
  /// **'Steps Total ({period})'**
  String stepsTotal(String period);

  /// Label for large dataset toggle
  ///
  /// In en, this message translates to:
  /// **'Large Dataset'**
  String get largeDataset;

  /// Label for 7 days date range
  ///
  /// In en, this message translates to:
  /// **'7d'**
  String get dateRange7d;

  /// Label for 30 days date range
  ///
  /// In en, this message translates to:
  /// **'30d'**
  String get dateRange30d;

  /// Label for 90 days date range
  ///
  /// In en, this message translates to:
  /// **'90d'**
  String get dateRange90d;

  /// HRV chart title
  ///
  /// In en, this message translates to:
  /// **'HRV'**
  String get hrv;

  /// HRV axis label with unit
  ///
  /// In en, this message translates to:
  /// **'HRV (ms)'**
  String get hrvMs;

  /// RHR chart title
  ///
  /// In en, this message translates to:
  /// **'RHR'**
  String get rhr;

  /// RHR axis label with unit
  ///
  /// In en, this message translates to:
  /// **'RHR (bpm)'**
  String get rhrBpm;

  /// Steps chart title
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get steps;

  /// HRV chart tooltip format
  ///
  /// In en, this message translates to:
  /// **'{date}\nHRV {value} ms\nMean {mean} ms\nStd Dev {stdDev}'**
  String hrvTooltip(String date, String value, String mean, String stdDev);

  /// RHR chart tooltip format
  ///
  /// In en, this message translates to:
  /// **'{date}\nRHR {value} bpm'**
  String rhrTooltip(String date, String value);

  /// Steps chart tooltip format
  ///
  /// In en, this message translates to:
  /// **'{date}\nSteps {value}'**
  String stepsTooltip(String date, String value);

  /// Default user name placeholder
  ///
  /// In en, this message translates to:
  /// **'John Doe'**
  String get userName;

  /// Default user email placeholder
  ///
  /// In en, this message translates to:
  /// **'john.doe@example.com'**
  String get userEmail;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
