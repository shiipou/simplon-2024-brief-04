
-- Affiche les information d'un utilisateur
SELECT "id", "username" FROM "user"
WHERE "id" = 1;

-- Affiche les posts publique
SELECT *
FROM "view_post"
WHERE "group" IS NULL
    OR "is_public" = TRUE;

-- Affiche les posts du groupe SecOps si l'utilisateur y a accès
SELECT p.*
FROM "view_post" p
    LEFT JOIN "user" u ON u.id = p.owner
    LEFT JOIN "group" g ON g.id = p.group
    LEFT JOIN "group_users" gu ON gu.user = u.id AND gu.group = g.id
WHERE p.group IS NULL OR gu.user = 1;

-- Affiche le fil d'actualité des plus populaire (avec pagination)
SELECT * FROM "view_post_trending"
WHERE "parent" IS NULL
    AND "group" IS NULL 
    OR "is_public" = TRUE
LIMIT 5 OFFSET 0;
-- page 2
SELECT * FROM "view_post_trending"
WHERE "parent" IS NULL
    AND "group" IS NULL 
    OR "is_public" = TRUE
LIMIT 5 OFFSET 5;

-- Affiche le fil d'actualité des plus récents (avec pagination)
-- page 1
SELECT * FROM "view_post_newest"
WHERE parent IS NULL
    AND "group" IS NULL 
    OR "is_public" = TRUE
LIMIT 5 OFFSET 0;
-- page 2
SELECT * FROM "view_post_newest"
WHERE parent IS NULL
    AND "group" IS NULL 
    OR "is_public" = TRUE
LIMIT 5 OFFSET 5;

-- Modification des settings utilisateurs
-- Je liste les settings avant et après pour voir les différences
SELECT * FROM "settings" WHERE "user" = 1;
UPDATE "settings" SET "notification_enabled" = TRUE
WHERE "user" = 1;
SELECT * FROM "settings" WHERE "user" = 1;

-- Recherche des posts par mots clés.
SELECT * FROM "view_post"
WHERE "content" ILIKE '%python%';

-- Recherche des users par username ou nom
SELECT * FROM "user"
WHERE "name" ILIKE '%jean%' OR "username" ILIKE '%jean%';

-- Affiche tous les commentaires et tous les sous-commentaires récursivement du post d'id 6
SELECT *
FROM GetPostComments(6);
