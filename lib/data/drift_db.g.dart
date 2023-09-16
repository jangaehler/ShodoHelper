// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_db.dart';

// ignore_for_file: type=lint
class $LyricsTable extends Lyrics with TableInfo<$LyricsTable, Lyric> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LyricsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _artistMeta = const VerificationMeta('artist');
  @override
  late final GeneratedColumn<String> artist = GeneratedColumn<String>(
      'artist', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _langMeta = const VerificationMeta('lang');
  @override
  late final GeneratedColumn<String> lang = GeneratedColumn<String>(
      'lang', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, content, artist, lang];
  @override
  String get aliasedName => _alias ?? 'lyrics';
  @override
  String get actualTableName => 'lyrics';
  @override
  VerificationContext validateIntegrity(Insertable<Lyric> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    }
    if (data.containsKey('artist')) {
      context.handle(_artistMeta,
          artist.isAcceptableOrUnknown(data['artist']!, _artistMeta));
    }
    if (data.containsKey('lang')) {
      context.handle(
          _langMeta, lang.isAcceptableOrUnknown(data['lang']!, _langMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Lyric map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Lyric(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content']),
      artist: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}artist']),
      lang: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lang']),
    );
  }

  @override
  $LyricsTable createAlias(String alias) {
    return $LyricsTable(attachedDatabase, alias);
  }
}

class Lyric extends DataClass implements Insertable<Lyric> {
  final int id;
  final String? content;
  final String? artist;
  final String? lang;
  const Lyric({required this.id, this.content, this.artist, this.lang});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    if (!nullToAbsent || artist != null) {
      map['artist'] = Variable<String>(artist);
    }
    if (!nullToAbsent || lang != null) {
      map['lang'] = Variable<String>(lang);
    }
    return map;
  }

  LyricsCompanion toCompanion(bool nullToAbsent) {
    return LyricsCompanion(
      id: Value(id),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      artist:
          artist == null && nullToAbsent ? const Value.absent() : Value(artist),
      lang: lang == null && nullToAbsent ? const Value.absent() : Value(lang),
    );
  }

  factory Lyric.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Lyric(
      id: serializer.fromJson<int>(json['id']),
      content: serializer.fromJson<String?>(json['content']),
      artist: serializer.fromJson<String?>(json['artist']),
      lang: serializer.fromJson<String?>(json['lang']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'content': serializer.toJson<String?>(content),
      'artist': serializer.toJson<String?>(artist),
      'lang': serializer.toJson<String?>(lang),
    };
  }

  Lyric copyWith(
          {int? id,
          Value<String?> content = const Value.absent(),
          Value<String?> artist = const Value.absent(),
          Value<String?> lang = const Value.absent()}) =>
      Lyric(
        id: id ?? this.id,
        content: content.present ? content.value : this.content,
        artist: artist.present ? artist.value : this.artist,
        lang: lang.present ? lang.value : this.lang,
      );
  @override
  String toString() {
    return (StringBuffer('Lyric(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('artist: $artist, ')
          ..write('lang: $lang')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, content, artist, lang);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Lyric &&
          other.id == this.id &&
          other.content == this.content &&
          other.artist == this.artist &&
          other.lang == this.lang);
}

class LyricsCompanion extends UpdateCompanion<Lyric> {
  final Value<int> id;
  final Value<String?> content;
  final Value<String?> artist;
  final Value<String?> lang;
  const LyricsCompanion({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
    this.artist = const Value.absent(),
    this.lang = const Value.absent(),
  });
  LyricsCompanion.insert({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
    this.artist = const Value.absent(),
    this.lang = const Value.absent(),
  });
  static Insertable<Lyric> custom({
    Expression<int>? id,
    Expression<String>? content,
    Expression<String>? artist,
    Expression<String>? lang,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (content != null) 'content': content,
      if (artist != null) 'artist': artist,
      if (lang != null) 'lang': lang,
    });
  }

  LyricsCompanion copyWith(
      {Value<int>? id,
      Value<String?>? content,
      Value<String?>? artist,
      Value<String?>? lang}) {
    return LyricsCompanion(
      id: id ?? this.id,
      content: content ?? this.content,
      artist: artist ?? this.artist,
      lang: lang ?? this.lang,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (artist.present) {
      map['artist'] = Variable<String>(artist.value);
    }
    if (lang.present) {
      map['lang'] = Variable<String>(lang.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LyricsCompanion(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('artist: $artist, ')
          ..write('lang: $lang')
          ..write(')'))
        .toString();
  }
}

abstract class _$LyricsDatabase extends GeneratedDatabase {
  _$LyricsDatabase(QueryExecutor e) : super(e);
  late final $LyricsTable lyrics = $LyricsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [lyrics];
}
