variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Yandex Folder ID"
  type        = string
}

variable "yc_token" {
  description = "OAuth токен Yandex Cloud"
  type        = string
}

variable "db_password" {
  description = "Пароль для PostgreSQL пользователя"
  type        = string
}

variable "access_key" {
  description = "S3 Access Key"
  type        = string
}

variable "secret_key" {
  description = "S3 Secret Key"
  type        = string
}

variable "zone" {
  description = "Зона доступности сервера "
  type        = string
}

variable "image_id" {
  description = "ID базового образа (Ubuntu 22.04 LTS)"
  type        = string
}
