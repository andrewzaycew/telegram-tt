-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "telegramChatId" TEXT,
    "username" TEXT,
    "diamonds" INTEGER NOT NULL DEFAULT 0,
    "isBanned" BOOLEAN NOT NULL DEFAULT false,
    "banReason" TEXT,
    "giftsSpamBlocked" BOOLEAN NOT NULL DEFAULT false
);

-- CreateTable
CREATE TABLE "NftUsername" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "userId" TEXT NOT NULL,
    "handle" TEXT NOT NULL,
    CONSTRAINT "NftUsername_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Conversation" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userAId" TEXT NOT NULL,
    "userBId" TEXT NOT NULL,
    CONSTRAINT "Conversation_userAId_fkey" FOREIGN KEY ("userAId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Conversation_userBId_fkey" FOREIGN KEY ("userBId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Message" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "conversationId" TEXT NOT NULL,
    "authorId" TEXT NOT NULL,
    "text" TEXT NOT NULL,
    CONSTRAINT "Message_conversationId_fkey" FOREIGN KEY ("conversationId") REFERENCES "Conversation" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Message_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Gift" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "priceDiamonds" INTEGER NOT NULL,
    "supply" INTEGER,
    "baseAssetId" TEXT,
    "isConvertible" BOOLEAN NOT NULL DEFAULT false,
    "upgradePrice" INTEGER
);

-- CreateTable
CREATE TABLE "GiftModel" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "giftId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "weight" INTEGER NOT NULL,
    "assetId" TEXT NOT NULL,
    CONSTRAINT "GiftModel_giftId_fkey" FOREIGN KEY ("giftId") REFERENCES "Gift" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "GiftBackdrop" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "giftId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "weight" INTEGER NOT NULL,
    CONSTRAINT "GiftBackdrop_giftId_fkey" FOREIGN KEY ("giftId") REFERENCES "Gift" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "UserGift" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "ownerId" TEXT NOT NULL,
    "giftId" TEXT NOT NULL,
    "isCollectible" BOOLEAN NOT NULL DEFAULT false,
    "serial" INTEGER,
    "modelId" TEXT,
    "backdropId" TEXT,
    CONSTRAINT "UserGift_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "UserGift_giftId_fkey" FOREIGN KEY ("giftId") REFERENCES "Gift" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "UserGift_modelId_fkey" FOREIGN KEY ("modelId") REFERENCES "GiftModel" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "UserGift_backdropId_fkey" FOREIGN KEY ("backdropId") REFERENCES "GiftBackdrop" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "DiamondTransaction" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" TEXT NOT NULL,
    "amount" INTEGER NOT NULL,
    "reason" TEXT NOT NULL,
    "externalRef" TEXT,
    CONSTRAINT "DiamondTransaction_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "PairingCode" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" DATETIME NOT NULL,
    "code" TEXT NOT NULL,
    "userId" TEXT,
    "usedAt" DATETIME,
    CONSTRAINT "PairingCode_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "AdminRoleAssignment" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" TEXT NOT NULL,
    "role" TEXT NOT NULL,
    CONSTRAINT "AdminRoleAssignment_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "User_telegramChatId_key" ON "User"("telegramChatId");

-- CreateIndex
CREATE UNIQUE INDEX "User_username_key" ON "User"("username");

-- CreateIndex
CREATE UNIQUE INDEX "NftUsername_handle_key" ON "NftUsername"("handle");

-- CreateIndex
CREATE UNIQUE INDEX "Conversation_userAId_userBId_key" ON "Conversation"("userAId", "userBId");

-- CreateIndex
CREATE UNIQUE INDEX "Gift_slug_key" ON "Gift"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "PairingCode_code_key" ON "PairingCode"("code");

-- CreateIndex
CREATE UNIQUE INDEX "AdminRoleAssignment_userId_role_key" ON "AdminRoleAssignment"("userId", "role");
