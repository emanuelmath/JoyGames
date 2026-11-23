using JoyGames.Core.Enums;
using JoyGames.Core.Exceptions;

namespace JoyGames.Core.Entities
{
    public class Game
    {
        public Guid Id { get; private set; }
        public string Title { get; private set; }
        public string Description { get; private set; }
        public CategoryEnum CategoryId { get; private set; }
        public int CompanyId { get; private set; }
        public DateTime ReleaseDate { get; private set; }
        public long SoldCopies { get; private set; }
        public string? ImageUrl { get; private set; }
        public string? TrailerUrl { get; private set; }

        public Game(string title, string description, CategoryEnum categoryId, 
            int companyId, DateTime releaseDate, long soldCopies, 
            string? imageUrl = null, string? trailerUrl = null)
        {
            if (string.IsNullOrWhiteSpace(title)) throw new DomainException("El título del juego no debe ir vacío.");
            if (string.IsNullOrWhiteSpace(description)) throw new DomainException("La descripción del juego no debe ir vacía.");
            if (!Enum.IsDefined(categoryId)) throw new DomainException("El id de la categoría debe ser válido.");
            if (companyId <= 0) throw new DomainException("El id de la empresa debe ser válido.");
            if (soldCopies < 0) throw new DomainException("Las copias vendidas no deben ser menores a 0.");
            if (imageUrl is not null && string.IsNullOrWhiteSpace(imageUrl)) throw new DomainException("La url de la imagen del juego debe ser válida.");
            if (trailerUrl is not null && !ValidateUrlType(trailerUrl)) throw new DomainException("La url del vídeo no está en el formato correcto.");

            Id = Guid.CreateVersion7();
            Title = title;
            Description = description;
            CategoryId = categoryId;
            CompanyId = companyId;
            ReleaseDate = releaseDate;
            SoldCopies = soldCopies;
            ImageUrl = imageUrl;
            TrailerUrl = trailerUrl;
        }

        private static bool ValidateUrlType(string url)
        {
            return url.StartsWith("https://www.youtube.com/embed/");
        }

        public void UpdateGame(string title, string description, CategoryEnum categoryId,
            int companyId, DateTime releaseDate, long soldCopies,
            string? imageUrl = null, string? trailerUrl = null)
        {
            if (string.IsNullOrWhiteSpace(title)) throw new DomainException("El título del juego no debe ir vacío.");
            if (string.IsNullOrWhiteSpace(description)) throw new DomainException("La descripción del juego no debe ir vacía.");
            if (!Enum.IsDefined(categoryId)) throw new DomainException("El id de la categoría debe ser válido.");
            if (companyId <= 0) throw new DomainException("El id de la empresa debe ser válido.");
            if (soldCopies < 0) throw new DomainException("Las copias vendidas no deben ser menores a 0.");
            if (imageUrl is not null && string.IsNullOrWhiteSpace(imageUrl)) throw new DomainException("La url de la imagen del juego debe ser válida.");
            if (trailerUrl is not null && !ValidateUrlType(trailerUrl)) throw new DomainException("La url del vídeo no está en el formato correcto.");

            Title = title;
            Description = description;
            CategoryId = categoryId;
            CompanyId = companyId;
            ReleaseDate = releaseDate;
            SoldCopies = soldCopies;
            ImageUrl = imageUrl;
            TrailerUrl = trailerUrl;
        }

    }
}
