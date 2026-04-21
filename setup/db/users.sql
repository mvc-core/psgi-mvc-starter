-- Host: db-host-ssp-603160:3306
-- Erstellungszeit: 21. Apr 2026 um 11:17
-- Server-Version: 10.11.16-MariaDB-ubu2204

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

-- --------------------------------------------------------
--
-- Tabellenstruktur für Tabelle `users`
--

CREATE TABLE `users` (
  `id` 			mediumint(8) UNSIGNED 		NOT NULL,
  `status` 		tinyint(4) 			NOT NULL DEFAULT 1 COMMENT '1=new, 2=released, 3=blocked',
  `tstamp` 		timestamp 			NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `uname` 		char(63) 			NOT NULL,
  `password_hash` 	char(127) 			CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '0',
  `pass` 		char(63) 			NOT NULL,
  `email` 		char(255) 			NOT NULL,
  `newsletter` 		tinyint(4) 			NOT NULL DEFAULT 1,
  `gender` 		tinyint(4) 			NOT NULL DEFAULT 1 COMMENT '1=male, 2=female',
  `dob` 		date 				DEFAULT NULL COMMENT 'Date of Birth',
  `is_admin` 		tinyint(1) 			NOT NULL DEFAULT 0,
  `is_devel` 		tinyint(1) 			NOT NULL DEFAULT 0,
  `rel_token` 		char(8) 			DEFAULT NULL COMMENT 'Release Token'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Daten für Tabelle `users`
--
INSERT INTO `users` (`id`, `status`, `tstamp`, `uname`, `password_hash`, `pass`, `email`, `newsletter`, `gender`, `dob`, `is_admin`, `is_devel`, `rel_token`) VALUES
(1, 2, '2026-03-25 09:25:11', 'admin', '$argon2id$v=19$m=16384,t=3,p=1$Kl85ERvRmzUDNKlmFA6YKg$K8AoqMsxJ+COEdbxi85uaA', '', 'admin@x.pgate.net',  0, 1, NULL,         1, 0, NULL),
(2, 2, '2026-03-25 19:41:56', 'reto2', '$argon2id$v=19$m=16384,t=3,p=1$FsN0wnpCVkhJhmO3OHPQrQ$eeRdNxahsdM9IWaoX43AVA', '', 'reto2@algonetic.ch', 0, 1, '1970-01-01', 1, 1, '');

--
-- Indizes für die Tabelle `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uname` (`uname`);

--
-- AUTO_INCREMENT für Tabelle `users`
--
ALTER TABLE `users`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;
