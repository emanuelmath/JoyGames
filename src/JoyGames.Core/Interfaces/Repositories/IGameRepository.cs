using JoyGames.Core.Entities;

namespace JoyGames.Core.Interfaces.Repositories
{
    public interface IGameRepository
    {
        Task<Guid?> AddAsync(Game game);
        Task UpdateAsync(Game game);

    }
}
