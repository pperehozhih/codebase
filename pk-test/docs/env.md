Переменные окружения
====================

PK_TEST_BASE_PORT -- базовый порт для тестирования "слушающих" сервисов
  (каждый новый тест получит следующий порт, начиная с base)
  По умолчанию 50000
PK_TEST_DB_HOST -- хост с тестовым MySQL (по умолчанию localhost)
PK_TEST_DB_PORT -- порт MySQL (по умолчанию 3306)
PK_TEST_DB_NAME -- имя тестовой базы MySQL (база должна существовать,
 по умолчанию "pk-test")
PK_TEST_DB_USER -- имя пользователя MySQL для тестов (по умолчанию root)
PK_TEST_DB_PASSWORD  пароль тестового пользователя MySQL (по умолчанию 12345)

Примечание: большая часть переменных непосредственно кодом pk-test никак не
распознается, но является policy для тестового окружения, и должно
распознаваться самими тестами.