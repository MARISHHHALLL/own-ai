-- CreateTable
CREATE TABLE "Accounts" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "isAdmin" BOOLEAN NOT NULL DEFAULT false
);

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "ChatLog" (
    "id" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "Messages" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "text" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "Messages_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "MessageRecipient" (
    "id" TEXT NOT NULL,
    "recipient_id" TEXT NOT NULL,
    "message_id" TEXT NOT NULL,
    CONSTRAINT "MessageRecipient_recipient_id_fkey" FOREIGN KEY ("recipient_id") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "MessageRecipient_message_id_fkey" FOREIGN KEY ("message_id") REFERENCES "Messages" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "Accounts_id_key" ON "Accounts"("id");

-- CreateIndex
CREATE UNIQUE INDEX "User_id_key" ON "User"("id");

-- CreateIndex
CREATE UNIQUE INDEX "ChatLog_id_key" ON "ChatLog"("id");

-- CreateIndex
CREATE UNIQUE INDEX "Messages_id_key" ON "Messages"("id");

-- CreateIndex
CREATE UNIQUE INDEX "MessageRecipient_id_key" ON "MessageRecipient"("id");
