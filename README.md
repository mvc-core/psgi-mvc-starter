# psgi-mvc-starter
PSGI MVC starter for Perl using Plack. Mason variant is “batteries included” (flexible, powerful), while TT offers a leaner, lightweight alternative.

```console
lib/MyApp/
├── Controller/          # Route-Handler (bereits vorhanden)
│   ├── Home.pm
│   ├── Foo.pm
│   └── Subfoo.pm
│
├── Model/               # Datenbankzugriff / Business-Logik
│   ├── User.pm          # z.B. MyApp::Model::User->get_by_id(123)
│   └── Product.pm
│
├── Service/             # Komplexere Geschäftslogik, API-Calls, etc.
│   ├── Auth.pm          # Login/Logout/Session-Prüfung
│   └── Mailer.pm
│
├── Util/                # Hilfsfunktionen ohne Business-Bezug
│   └── Format.pm        # Datumsformatierung, Strings, etc.
│
├── DB.pm                # Datenbankverbindung (bereits vorhanden)
└── Mason.pm             # Mason-Konfiguration (bereits vorhanden)
```

## Dependencies

```console
apt install libdancer2-perl libjson-maybexs-perl
```
