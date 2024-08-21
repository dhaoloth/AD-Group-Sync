# Импортируем модуль ActiveDirectory
Import-Module ActiveDirectory

# Запрашиваем логины эталонного и целевого пользователей
$referenceUser = Read-Host "Введите логин эталонного пользователя"
$targetUser = Read-Host "Введите логин целевого пользователя"

# Проверяем, существуют ли пользователи
if (-not (Get-ADUser -Identity $referenceUser -ErrorAction SilentlyContinue)) {
    Write-Error "Эталонный пользователь $referenceUser не найден."
    Read-Host "Нажмите Enter для закрытия скрипта"
    exit 1
}

if (-not (Get-ADUser -Identity $targetUser -ErrorAction SilentlyContinue)) {
    Write-Error "Целевой пользователь $targetUser не найден."
    Read-Host "Нажмите Enter для закрытия скрипта"
    exit 1
}

Write-Output "Получение списка групп для эталонного пользователя $referenceUser..."
# Получаем список групп эталонного пользователя
$referenceGroups = Get-ADPrincipalGroupMembership -Identity $referenceUser | Select-Object -ExpandProperty Name

Write-Output "Получение списка групп для целевого пользователя $targetUser..."
# Получаем список групп целевого пользователя
$targetGroups = Get-ADPrincipalGroupMembership -Identity $targetUser | Select-Object -ExpandProperty Name

Write-Output "Определение групп, которые нужно добавить..."
# Находим группы, которые есть у эталонного пользователя, но отсутствуют у целевого
$groupsToAdd = Compare-Object -ReferenceObject $referenceGroups -DifferenceObject $targetGroups -PassThru | Where-Object { $_.SideIndicator -eq "<=" }

if ($groupsToAdd.Count -eq 0) {
    Write-Output "Целевой пользователь $targetUser уже состоит во всех группах эталонного пользователя $referenceUser."
    Read-Host "Нажмите Enter для закрытия скрипта"
    exit 0
}

Write-Output "Добавление целевого пользователя $targetUser в группы: $($groupsToAdd -join ', ')..."
# Добавляем целевого пользователя в найденные группы
foreach ($groupName in $groupsToAdd) {
    try {
        # Проверяем существование группы перед добавлением
        $group = Get-ADGroup -Filter { Name -eq $groupName } -ErrorAction Stop
        if ($group) {
            Add-ADGroupMember -Identity $group -Members $targetUser
            Write-Output "Пользователь $targetUser добавлен в группу $groupName."
        } else {
            Write-Error "Группа $groupName не найдена в Active Directory."
        }
    } catch {
        Write-Error "Ошибка при добавлении пользователя $targetUser в группу ${groupName}: $($_.Exception.Message)"
    }
}

Write-Output "Процесс завершен."
Read-Host "Нажмите Enter для закрытия скрипта"