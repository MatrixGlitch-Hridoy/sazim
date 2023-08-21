-- CreateEnum
CREATE TYPE "ProductStatus" AS ENUM ('Sold', 'Rent');

-- CreateEnum
CREATE TYPE "CategoryType" AS ENUM ('ELECTRONICS', 'FURNITURE', 'HOME_APPLIANCES', 'SPORTING_GOODS', 'OUTDOOR', 'TOYS');

-- CreateTable
CREATE TABLE "Product" (
    "product_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "status" "ProductStatus" NOT NULL,
    "price" DOUBLE PRECISION,

    CONSTRAINT "Product_pkey" PRIMARY KEY ("product_id")
);

-- CreateTable
CREATE TABLE "Category" (
    "category_id" SERIAL NOT NULL,
    "name" "CategoryType" NOT NULL,
    "description" TEXT,

    CONSTRAINT "Category_pkey" PRIMARY KEY ("category_id")
);

-- CreateTable
CREATE TABLE "Rent" (
    "rent_id" SERIAL NOT NULL,
    "product_id" INTEGER NOT NULL,
    "user_id" INTEGER,
    "start_date" TIMESTAMP(3) NOT NULL,
    "end_date" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Rent_pkey" PRIMARY KEY ("rent_id")
);

-- CreateTable
CREATE TABLE "_CategoryToProduct" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_CategoryToProduct_AB_unique" ON "_CategoryToProduct"("A", "B");

-- CreateIndex
CREATE INDEX "_CategoryToProduct_B_index" ON "_CategoryToProduct"("B");

-- AddForeignKey
ALTER TABLE "Rent" ADD CONSTRAINT "Rent_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Product"("product_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CategoryToProduct" ADD CONSTRAINT "_CategoryToProduct_A_fkey" FOREIGN KEY ("A") REFERENCES "Category"("category_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CategoryToProduct" ADD CONSTRAINT "_CategoryToProduct_B_fkey" FOREIGN KEY ("B") REFERENCES "Product"("product_id") ON DELETE CASCADE ON UPDATE CASCADE;
