using JoyGames.Core.Entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace JoyGames.Core.Interfaces.Repositories
{
    public interface ICompanyRepository
    {
        Task<int?> AddAsync(Company company);
    }
}
