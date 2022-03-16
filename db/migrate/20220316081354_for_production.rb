class ForProduction < ActiveRecord::Migration[6.0]
  def change
    create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
      t.string "name", null: false
      t.string "record_type", null: false
      t.bigint "record_id", null: false
      t.bigint "blob_id", null: false
      t.datetime "created_at", null: false
      t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
      t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
    end

    create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
      t.string "key", null: false
      t.string "filename", null: false
      t.string "content_type"
      t.text "metadata"
      t.bigint "byte_size", null: false
      t.string "checksum", null: false
      t.datetime "created_at", null: false
      t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
    end

    create_table "answers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
      t.bigint "friend_id"
      t.bigint "content_id"
      t.integer "result", limit: 1
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.index ["id"], name: "id", unique: true
      t.index ["id"], name: "result_id", unique: true
    end

    create_table "contents", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
      t.bigint "friend_id"
      t.string "intro"
      t.string "question"
      t.string "option_a"
      t.string "option_b"
      t.string "option_c"
      t.string "option_d"
      t.string "answer"
      t.boolean "selected_flag", default: false
      t.boolean "done_flag", default: false
      t.text "updated_at"
      t.text "created_at"
    end

    create_table "friends", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
      t.string "full_name"
      t.string "last_name"
      t.string "first_name"
      t.string "last_name_en"
      t.string "first_name_en"
      t.string "group"
      t.string "caption"
      t.string "job"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
    end

    add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  end
end
