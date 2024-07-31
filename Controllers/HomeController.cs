using doan.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using PagedList.Core;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using System.Net;

namespace doan.Controllers
{
    public class HomeController : Controller
    {
        private readonly FivemenCoffeeContext _context;
        public HomeController(FivemenCoffeeContext context)
        {
            _context = context;
        }
        public IActionResult Index(int? page)
        {
            try
            {
                var pageNumber = page == null || page <= 0 ? 1 : page.Value;
                var pageSize = 8;
                var IsSanphams = _context.Sanpham
                    .Include(s => s.Hinhanh) // Đảm bảo rằng danh sách hình ảnh liên quan được nạp
                    .AsNoTracking()
                    .OrderBy(x => x.MaSp);

                PagedList<doan.Models.Sanpham> models = new PagedList<doan.Models.Sanpham>(IsSanphams, pageNumber, pageSize);
                ViewBag.CurrentPage = pageNumber;
                return View(models);
            }
            catch
            {
                return RedirectToAction("Index", "Home");
            }
        }

        public IActionResult Contact()
        {
            return View();
        }
        public IActionResult About()
        {
            return View();
        }
        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}